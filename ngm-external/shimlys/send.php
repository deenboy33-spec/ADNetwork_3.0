<?php
/**
 * ADCityCentral SMI API - send.php
 * Shimly-SMI kompatible Auszahlungsschnittstelle
 * MIT wwdclub.de Kompatibilität
 */

header('Content-Type: text/plain; charset=utf-8');

require_once dirname(__DIR__, 2) . '/wp-config.php';

// Alte wwdclub-Parameter in SMI-Format umwandeln
if (isset($_GET['api_id']) && isset($_GET['api_pw'])) {
    $mi_id = $_GET['api_id'];
    $mi_pw = $_GET['api_pw'];
    $s_id  = $_GET['user_id'] ?? '';
    $s_pw  = $_GET['user_pw'] ?? '';
    $n     = floatval($_GET['vol'] ?? 0);
    $s     = $_GET['description'] ?? 'WWDClub Auszahlung';
    $code  = $_GET['subid'] ?? bin2hex(random_bytes(8));
} else {
    $mi_id = isset($_GET['mi_id']) ? trim($_GET['mi_id']) : '';
    $mi_pw = isset($_GET['mi_pw']) ? trim($_GET['mi_pw']) : '';
    $s_id  = isset($_GET['s_id'])  ? trim($_GET['s_id'])  : '';
    $s     = isset($_GET['s'])     ? trim($_GET['s'])     : 'Auszahlung';
    $n     = isset($_GET['n'])     ? floatval($_GET['n'])  : 0;
    $code  = isset($_GET['code'])  ? trim($_GET['code'])  : '';
    $s_pw  = isset($_GET['s_pw'])  ? trim($_GET['s_pw'])  : '';
    $tpw   = isset($_GET['tpw'])   ? trim($_GET['tpw'])   : '';
}

if (empty($mi_id) || empty($mi_pw)) {
    die("1002|SMI Account nicht konfiguriert|0|0|0|0|0");
}

if (empty($s_id)) {
    die("1006|User existiert nicht|0|0|0|0|0");
}

if ($n < 100000) {
    die("1011|Ungültiger Buchungsbetrag|0|0|0|0|0");
}

$passwort = !empty($s_pw) ? $s_pw : (!empty($tpw) ? $tpw : '');
if (empty($passwort)) {
    die("1009|Transfer-Passwort erforderlich|0|0|0|0|0");
}

$mysqli = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
if ($mysqli->connect_error) {
    die("1099|DB-Verbindungsfehler|0|0|0|0|0");
}

// Tabellen erstellen falls nicht vorhanden
$mysqli->query("CREATE TABLE IF NOT EXISTS vms_schnittstelle (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    passwort VARCHAR(100) NOT NULL,
    kontostand DECIMAL(20,8) DEFAULT 0,
    aktiv TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
)");

$mysqli->query("CREATE TABLE IF NOT EXISTS vms_konten (
    id INT AUTO_INCREMENT PRIMARY KEY,
    k_username VARCHAR(100) NOT NULL UNIQUE,
    k_passwort VARCHAR(100) NOT NULL,
    k_guthaben DECIMAL(20,8) DEFAULT 0,
    k_status TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
)");

$mysqli->query("CREATE TABLE IF NOT EXISTS vms_schnittstelle_buchungen (
    id INT AUTO_INCREMENT PRIMARY KEY,
    schnittstelle_id INT NOT NULL,
    konto_id INT NOT NULL,
    betrag DECIMAL(20,8) NOT NULL,
    betrag_vorher DECIMAL(20,8) NOT NULL,
    typ ENUM('send','get') DEFAULT 'send',
    betreff VARCHAR(255),
    trans_code VARCHAR(50),
    status VARCHAR(20) DEFAULT 'completed',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
)");

// SMI-Account validieren - suche nach Name ODER ID
$stmt = $mysqli->prepare("SELECT id, name, passwort, kontostand FROM vms_schnittstelle WHERE (name = ? OR id = ?) AND passwort = ? AND aktiv = 1");
$stmt->bind_param('sis', $mi_id, $mi_id, $mi_pw);
$stmt->execute();
$smi = $stmt->get_result()->fetch_assoc();

if (!$smi) {
    die("1003|SMI Passwort falsch|0|0|0|0|0");
}

if ($smi['kontostand'] < $n) {
    die("1010|SMI Account zu geringer Kontostand|0|0|0|0|0");
}

$stmt = $mysqli->prepare("SELECT id, k_username, k_guthaben, k_status FROM vms_konten WHERE k_username = ? AND k_passwort = ?");
$stmt->bind_param('ss', $s_id, $passwort);
$stmt->execute();
$user = $stmt->get_result()->fetch_assoc();

if (!$user) {
    die("1009|Shimly User SMI Passwort falsch|0|0|0|0|0");
}

if ($user['k_status'] == 1) {
    die("1007|Shimly User gesperrt|0|0|0|0|0");
}

$user_balance = $user['k_guthaben'];

$mysqli->begin_transaction();

try {
    $stmt = $mysqli->prepare("UPDATE vms_schnittstelle SET kontostand = kontostand - ? WHERE id = ?");
    $stmt->bind_param('di', $n, $smi['id']);
    $stmt->execute();
    
    $stmt = $mysqli->prepare("UPDATE vms_konten SET k_guthaben = k_guthaben + ? WHERE id = ?");
    $stmt->bind_param('di', $n, $user['id']);
    $stmt->execute();
    
    $trans_code = $code ?: bin2hex(random_bytes(8));
    $stmt = $mysqli->prepare("INSERT INTO vms_schnittstelle_buchungen (schnittstelle_id, konto_id, betrag, betrag_vorher, typ, betreff, trans_code, status, created_at) VALUES (?, ?, ?, ?, 'send', ?, ?, 'completed', NOW())");
    $stmt->bind_param('iiddss', $smi['id'], $user['id'], $n, $user_balance, $s, $trans_code);
    $stmt->execute();
    $booking_id = $mysqli->insert_id;
    
    $mysqli->commit();
    
    $new_smi_balance = $smi['kontostand'] - $n;
    $new_user_balance = $user_balance + $n;
    
    die(sprintf("1001|OK|%.2f|%d|%.2f|0|0", $new_smi_balance, $booking_id, $new_user_balance));
    
} catch (Exception $e) {
    $mysqli->rollback();
    die("1099|Transaktionsfehler|0|0|0|0|0");
}
