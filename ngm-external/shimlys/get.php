<?php
/**
 * ADCityCentral SMI API - get.php
 * Einzahlung empfangen (Shimly-SMI kompatibel)
 */

header('Content-Type: text/plain; charset=utf-8');

$wp_config = dirname(__DIR__, 2) . '/wp-config.php';
if (!file_exists($wp_config)) {
    die("1099|wp-config.php nicht gefunden|0|0|0|0|0");
}
require_once $wp_config;

$mi_id = isset($_GET['mi_id']) ? trim($_GET['mi_id']) : '';
$mi_pw = isset($_GET['mi_pw']) ? trim($_GET['mi_pw']) : '';
$s_id  = isset($_GET['s_id'])  ? trim($_GET['s_id'])  : '';
$s_pw  = isset($_GET['s_pw'])  ? trim($_GET['s_pw'])  : '';
$s     = isset($_GET['s'])     ? trim($_GET['s'])     : 'Einzahlung';
$n     = isset($_GET['n'])     ? floatval($_GET['n'])  : 0;
$code  = isset($_GET['code'])  ? trim($_GET['code'])  : '';

if (empty($mi_id) || empty($mi_pw)) {
    die("1002|SMI Account nicht konfiguriert|0|0|0|0|0");
}

if (empty($s_id)) {
    die("1006|User existiert nicht|0|0|0|0|0");
}

if ($n < 1) {
    die("1011|Ungültiger Buchungsbetrag|0|0|0|0|0");
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

// SMI-Account validieren
$stmt = $mysqli->prepare("SELECT id, name, kontostand FROM vms_schnittstelle WHERE name = ? AND passwort = ? AND aktiv = 1");
$stmt->bind_param('ss', $mi_id, $mi_pw);
$stmt->execute();
$smi = $stmt->get_result()->fetch_assoc();

if (!$smi) {
    die("1003|SMI Passwort falsch|0|0|0|0|0");
}

// User validieren (mit oder ohne Passwort)
if (!empty($s_pw)) {
    $stmt = $mysqli->prepare("SELECT id, k_username, k_guthaben, k_status FROM vms_konten WHERE k_username = ? AND k_passwort = ?");
    $stmt->bind_param('ss', $s_id, $s_pw);
} else {
    $stmt = $mysqli->prepare("SELECT id, k_username, k_guthaben, k_status FROM vms_konten WHERE k_username = ?");
    $stmt->bind_param('s', $s_id);
}
$stmt->execute();
$user = $stmt->get_result()->fetch_assoc();

if (!$user) {
    die("1006|Shimly User existiert nicht|0|0|0|0|0");
}

if ($user['k_status'] == 1) {
    die("1007|Shimly User gesperrt|0|0|0|0|0");
}

// User-Guthaben prüfen
if ($user['k_guthaben'] < $n) {
    die("1008|Shimly User zu geringer Kontostand|0|0|0|0|0");
}

$user_balance = $user['k_guthaben'];

// Transaktion
$mysqli->begin_transaction();

try {
    // User-Kontostand reduzieren
    $stmt = $mysqli->prepare("UPDATE vms_konten SET k_guthaben = k_guthaben - ? WHERE id = ?");
    $stmt->bind_param('di', $n, $user['id']);
    $stmt->execute();
    
    // SMI-Guthaben erhöhen
    $stmt = $mysqli->prepare("UPDATE vms_schnittstelle SET kontostand = kontostand + ? WHERE id = ?");
    $stmt->bind_param('di', $n, $smi['id']);
    $stmt->execute();
    
    // Buchung speichern
    $stmt = $mysqli->prepare("INSERT INTO vms_schnittstelle_buchungen (schnittstelle_id, konto_id, betrag, betrag_vorher, typ, betreff, trans_code, status, created_at) VALUES (?, ?, ?, ?, 'get', ?, ?, 'completed', NOW())");
    $stmt->bind_param('iiddss', $smi['id'], $user['id'], $n, $user_balance, $s, $code);
    $stmt->execute();
    $booking_id = $mysqli->insert_id;
    
    $mysqli->commit();
    
    $new_smi_balance = $smi['kontostand'] + $n;
    $new_user_balance = $user_balance - $n;
    
    die(sprintf("1001|OK|%.2f|%d|%.2f|0|0", $new_smi_balance, $booking_id, $new_user_balance));
    
} catch (Exception $e) {
    $mysqli->rollback();
    die("1099|Transaktionsfehler|0|0|0|0|0");
}
