<?php
/**
 * ADCityCentral SMI API - saldo.php
 * User-Guthaben prüfen (Shimly-SMI kompatibel)
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

if (empty($mi_id) || empty($mi_pw)) {
    die("1002|SMI Account nicht konfiguriert|0|0|0|0|0");
}

if (empty($s_id)) {
    die("1006|User existiert nicht|0|0|0|0|0");
}

$mysqli = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
if ($mysqli->connect_error) {
    die("1099|DB-Verbindungsfehler|0|0|0|0|0");
}

// SMI validieren
$stmt = $mysqli->prepare("SELECT id FROM vms_schnittstelle WHERE name = ? AND passwort = ? AND aktiv = 1");
$stmt->bind_param('ss', $mi_id, $mi_pw);
$stmt->execute();
if (!$stmt->get_result()->fetch_assoc()) {
    die("1003|SMI Passwort falsch|0|0|0|0|0");
}

// User suchen
if (!empty($s_pw)) {
    $stmt = $mysqli->prepare("SELECT k_username, k_guthaben FROM vms_konten WHERE k_username = ? AND k_passwort = ?");
    $stmt->bind_param('ss', $s_id, $s_pw);
} else {
    $stmt = $mysqli->prepare("SELECT k_username, k_guthaben FROM vms_konten WHERE k_username = ?");
    $stmt->bind_param('s', $s_id);
}
$stmt->execute();
$user = $stmt->get_result()->fetch_assoc();

if (!$user) {
    die("1006|Shimly User existiert nicht|0|0|0|0|0");
}

die(sprintf("1001|%.2f|0|0|0|0|0", $user['k_guthaben']));
