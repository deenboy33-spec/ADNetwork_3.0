<?php
/**
 * ADCityCentral API Wrapper - wf-api/sendtoshimly
 * Kompatibilitätslayer für alte WWDClub-Bridge
 * 
 * Wandelt alte API-Parameter in SMI-Format um
 * Version: 1.0 - Funktioniert mit api_id=19 und beliebigem Passwort
 */

header('Content-Type: text/plain; charset=utf-8');

require_once dirname(__DIR__) . '/wp-config.php';

// Alte API-Parameter
$api_id  = isset($_GET['api_id'])  ? trim($_GET['api_id'])  : '';
$api_pw  = isset($_GET['api_pw'])  ? trim($_GET['api_pw'])  : '';
$project = isset($_GET['project']) ? intval($_GET['project']) : 0;
$user_id = isset($_GET['user_id']) ? trim($_GET['user_id']) : '';
$user_pw = isset($_GET['user_pw']) ? trim($_GET['user_pw']) : '';
$vol     = isset($_GET['vol'])     ? intval($_GET['vol'])   : 0;
$des     = isset($_GET['description']) ? trim($_GET['description']) : 'WWDClub Auszahlung';

if (empty($api_id) || empty($api_pw)) {
    die("1100|API-Account nicht gefunden|-1|-1|-1|-1|-1|-1");
}

if (empty($user_id)) {
    die("1200|Shimly-ID ist auf der Bank noch unbekannt|-1|-1|-1|-1|-1|-1");
}

if ($vol < 100000) {
    die("1500|Mindestbetrag von 100000 GSC unterschritten|-1|-1|-1|-1|-1|-1");
}

// DB-Verbindung
$mysqli = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
if ($mysqli->connect_error) {
    die("3000|Datenbankfehler|-1|-1|-1|-1|-1|-1");
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
// Für api_id=19 (wwdclub) — verwende immer wwdclub-Account (Fallback)
if ($api_id === '19') {
    $stmt = $mysqli->prepare("SELECT id, name, passwort, kontostand FROM vms_schnittstelle WHERE name = 'wwdclub' AND aktiv = 1");
    $stmt->execute();
    $smi = $stmt->get_result()->fetch_assoc();
    
    if (!$smi) {
        // Erstelle wwdclub Account mit 100M GSC
        $wwdclub_pw = hash('sha256', 'wwdclub-default-pw');
        $stmt = $mysqli->prepare("INSERT INTO vms_schnittstelle (name, passwort, kontostand, aktiv) VALUES ('wwdclub', ?, 100000000, 1)");
        $stmt->bind_param('s', $wwdclub_pw);
        $stmt->execute();
        
        $smi = [
            'id' => $mysqli->insert_id,
            'name' => 'wwdclub',
            'passwort' => $wwdclub_pw,
            'kontostand' => 100000000
        ];
    }
} else {
    // Normaler Account-Check für andere api_id
    $stmt = $mysqli->prepare("SELECT id, name, passwort, kontostand FROM vms_schnittstelle WHERE name = ? AND passwort = ? AND aktiv = 1");
    $stmt->bind_param('ss', $api_id, $api_pw);
    $stmt->execute();
    $smi = $stmt->get_result()->fetch_assoc();
    
    if (!$smi) {
        die("1101|API-Passwort falsch|-1|-1|-1|-1|-1|-1");
    }
}

// SMI-Guthaben prüfen
if ($smi['kontostand'] < $vol) {
    die("1106|Zu wenig Guthaben im Bank-Sammelkonto|-1|-1|-1|-1|-1|-1");
}

// User validieren (user_id = k_username, user_pw = k_passwort)
$stmt = $mysqli->prepare("SELECT id, k_username, k_guthaben, k_status FROM vms_konten WHERE k_username = ? AND k_passwort = ?");
$stmt->bind_param('ss', $user_id, $user_pw);
$stmt->execute();
$user = $stmt->get_result()->fetch_assoc();

if (!$user) {
    die("1203|Falsches Transfer-Passwort|-1|-1|-1|-1|-1|-1");
}

if ($user['k_status'] == 1) {
    die("1202|Bank-Konto gesperrt|-1|-1|-1|-1|-1|-1");
}

$user_balance = $user['k_guthaben'];

// Transaktion
$mysqli->begin_transaction();

try {
    // SMI-Kontostand reduzieren
    $stmt = $mysqli->prepare("UPDATE vms_schnittstelle SET kontostand = kontostand - ? WHERE id = ?");
    $stmt->bind_param('di', $vol, $smi['id']);
    $stmt->execute();
    
    // User-Guthaben erhöhen
    $stmt = $mysqli->prepare("UPDATE vms_konten SET k_guthaben = k_guthaben + ? WHERE id = ?");
    $stmt->bind_param('di', $vol, $user['id']);
    $stmt->execute();
    
    // Buchung speichern
    $trans_code = bin2hex(random_bytes(8));
    $stmt = $mysqli->prepare("INSERT INTO vms_schnittstelle_buchungen (schnittstelle_id, konto_id, betrag, betrag_vorher, typ, betreff, trans_code, status, created_at) VALUES (?, ?, ?, ?, 'send', ?, ?, 'completed', NOW())");
    $stmt->bind_param('iiddss', $smi['id'], $user['id'], $vol, $user_balance, $des, $trans_code);
    $stmt->execute();
    $booking_id = $mysqli->insert_id;
    
    $mysqli->commit();
    
    $new_smi_balance = $smi['kontostand'] - $vol;
    $new_user_balance = $user_balance + $vol;
    
    // Altes Format: 1000|requests_free|requests_paid|api_balance|user_balance|wf_user_id|provisioned
    die("1000|0|0|" . round($new_smi_balance) . "|" . round($new_user_balance) . "|" . $user['id'] . "|1");
    
} catch (Exception $e) {
    $mysqli->rollback();
    die("3000|Datenbankfehler|-1|-1|-1|-1|-1|-1");
}
