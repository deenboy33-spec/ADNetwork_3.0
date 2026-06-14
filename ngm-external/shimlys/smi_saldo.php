<?php
/**
 * ADCityCentral SMI API - smi_saldo.php
 * SMI-Betreiber-Guthaben prüfen (Shimly-SMI kompatibel)
 */

header('Content-Type: text/plain; charset=utf-8');

$wp_config = dirname(__DIR__, 2) . '/wp-config.php';
if (!file_exists($wp_config)) {
    die("1099|wp-config.php nicht gefunden|0|0|0|0|0");
}
require_once $wp_config;

$mi_id = isset($_GET['mi_id']) ? trim($_GET['mi_id']) : '';
$mi_pw = isset($_GET['mi_pw']) ? trim($_GET['mi_pw']) : '';

if (empty($mi_id) || empty($mi_pw)) {
    die("1002|SMI Account nicht konfiguriert|0|0|0|0|0");
}

$mysqli = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
if ($mysqli->connect_error) {
    die("1099|DB-Verbindungsfehler|0|0|0|0|0");
}

$stmt = $mysqli->prepare("SELECT id, kontostand FROM vms_schnittstelle WHERE name = ? AND passwort = ? AND aktiv = 1");
$stmt->bind_param('ss', $mi_id, $mi_pw);
$stmt->execute();
$smi = $stmt->get_result()->fetch_assoc();

if (!$smi) {
    die("1003|SMI Passwort falsch|0|0|0|0|0");
}

$user_total = $mysqli->query("SELECT SUM(k_guthaben) FROM vms_konten")->fetch_row()[0] ?? 0;

die(sprintf("1001|%.2f|%.2f|0|0|0|0", $smi['kontostand'], $user_total));
