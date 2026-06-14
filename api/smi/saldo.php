<?php
/**
 * ADNetwork 3.0 - SMI Saldo API
 * Guthaben-Prüfung für externen Partner
 * 
 * Parameter:
 * - mi_id = SMI-ID des Partners
 * - mi_pw = SMI-Passwort des Partners
 * - s_id = User-Login
 * - s_pw = User-Passwort
 * 
 * Rückgabe:
 * - Erfolg: "user_id;balance;currency"
 * - Fehler: "0;0;0"
 */

header('Content-Type: text/plain; charset=utf-8');

require_once __DIR__ . '/../../config/database.php';

$mi_id = isset($_GET['mi_id']) ? intval($_GET['mi_id']) : 0;
$mi_pw = isset($_GET['mi_pw']) ? $_GET['mi_pw'] : '';
$s_id = isset($_GET['s_id']) ? $_GET['s_id'] : '';
$s_pw = isset($_GET['s_pw']) ? $_GET['s_pw'] : '';

$log_file = __DIR__ . '/../../logs/smi_saldo.log';
$log_entry = date('Y-m-d H:i:s') . " | Saldo API | mi_id=$mi_id | s_id=$s_id\n";
file_put_contents($log_file, $log_entry, FILE_APPEND | LOCK_EX);

if ($mi_id <= 0 || empty($mi_pw) || empty($s_id) || empty($s_pw)) {
    echo "0;0;0";
    exit;
}

try {
    $db = getDatabaseConnection();
    
    // 1. Partner validieren
    $stmt = $db->prepare("
        SELECT sp.* FROM netzwerk_smi_partner sp
        WHERE sp.smi_id = ? AND sp.passwort = ? AND sp.aktiv = 1
    ");
    $stmt->execute([$mi_id, $mi_pw]);
    $partner = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$partner) {
        $stmt = $db->prepare("
            SELECT * FROM netzwerk_schnittstelle 
            WHERE schnittstelle = 'shimly' 
            AND betreiber_id = ? AND betreiber_passwort = ?
        ");
        $stmt->execute([$mi_id, $mi_pw]);
        $partner = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$partner) {
            echo "0;0;0";
            file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: Ungültiger Partner\n", FILE_APPEND | LOCK_EX);
            exit;
        }
    }
    
    // 2. User validieren
    $stmt = $db->prepare("
        SELECT u.userid, u.nickname, u.passwort, u.ifpasswort, u.status
        FROM netzwerk_user u
        WHERE u.nickname = ?
    ");
    $stmt->execute([$s_id]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$user || $user['status'] != 1) {
        echo "0;0;0";
        file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: User nicht gefunden\n", FILE_APPEND | LOCK_EX);
        exit;
    }
    
    // 3. Passwort prüfen
    $pw_valid = false;
    if (strlen($s_pw) == 32 && $s_pw == $user['ifpasswort']) {
        $pw_valid = true;
    } elseif (strlen($user['passwort']) == 64 && hash('sha256', $s_pw) == $user['passwort']) {
        $pw_valid = true;
    } elseif (md5($s_pw) == $user['ifpasswort']) {
        $pw_valid = true;
    }
    
    if (!$pw_valid) {
        echo "0;0;0";
        file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: Passwort ungültig\n", FILE_APPEND | LOCK_EX);
        exit;
    }
    
    // 4. GSC-Guthaben abfragen
    $stmt = $db->prepare("SELECT gsc_balance FROM netzwerk_gsc_konten WHERE userid = ?");
    $stmt->execute([$user['userid']]);
    $gsc = $stmt->fetch(PDO::FETCH_ASSOC);
    
    $balance = $gsc['gsc_balance'] ?? 0;
    
    // Rückgabe: user_id;balance;currency
    echo $user['userid'] . ";" . $balance . ";GSC";
    file_put_contents($log_file, date('Y-m-d H:i:s') . " | ERFOLG: Saldo=$balance GSC\n", FILE_APPEND | LOCK_EX);
    
} catch (Exception $e) {
    echo "0;0;0";
    file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: " . $e->getMessage() . "\n", FILE_APPEND | LOCK_EX);
}
