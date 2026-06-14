<?php
/**
 * ADNetwork 3.0 - SMI Get API
 * GSC-Einzahlung von externem Partner (z.B. wwdclub.de)
 * 
 * Parameter:
 * - mi_id = SMI-ID des Partners
 * - mi_pw = SMI-Passwort des Partners
 * - s_id = User-Login
 * - s_pw = User-Passwort
 * - n = Betrag in GSC
 * - s = Buchungstext
 * 
 * Rückgabe:
 * - Erfolg: 1
 * - Fehler: 0
 */

header('Content-Type: text/plain; charset=utf-8');

require_once __DIR__ . '/../../config/database.php';

$mi_id = isset($_GET['mi_id']) ? intval($_GET['mi_id']) : 0;
$mi_pw = isset($_GET['mi_pw']) ? $_GET['mi_pw'] : '';
$s_id = isset($_GET['s_id']) ? $_GET['s_id'] : '';
$s_pw = isset($_GET['s_pw']) ? $_GET['s_pw'] : '';
$n = isset($_GET['n']) ? floatval($_GET['n']) : 0;
$buchungstext = isset($_GET['s']) ? $_GET['s'] : 'GSC Einzahlung';

$log_file = __DIR__ . '/../../logs/smi_get.log';
$log_entry = date('Y-m-d H:i:s') . " | Get API | mi_id=$mi_id | s_id=$s_id | n=$n\n";
file_put_contents($log_file, $log_entry, FILE_APPEND | LOCK_EX);

if ($mi_id <= 0 || empty($mi_pw) || empty($s_id) || empty($n)) {
    echo "0";
    exit;
}

try {
    $db = getDatabaseConnection();
    
    // 1. Partner validieren
    $stmt = $db->prepare("
        SELECT sp.*, s.kurs_ein 
        FROM netzwerk_smi_partner sp
        LEFT JOIN netzwerk_schnittstelle s ON s.schnittstelle = 'shimly'
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
            echo "0";
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
        echo "0";
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
        echo "0";
        file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: Passwort ungültig\n", FILE_APPEND | LOCK_EX);
        exit;
    }
    
    // 4. Mindesteinzahlung prüfen
    $min_einzahlung = $partner['min_einzahlung'] ?? 10000;
    if ($n < $min_einzahlung) {
        echo "0";
        file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: Betrag zu niedrig (min: $min_einzahlung)\n", FILE_APPEND | LOCK_EX);
        exit;
    }
    
    // 5. GSC gutschreiben
    $db->beginTransaction();
    
    $stmt = $db->prepare("
        INSERT INTO netzwerk_gsc_konten (userid, gsc_balance, gsc_gesamt, letzte_aktion)
        VALUES (?, ?, ?, UNIX_TIMESTAMP())
        ON DUPLICATE KEY UPDATE
            gsc_balance = gsc_balance + ?,
            gsc_gesamt = gsc_gesamt + ?,
            letzte_aktion = UNIX_TIMESTAMP()
    ");
    $stmt->execute([$user['userid'], $n, $n, $n, $n]);
    
    $db->commit();
    
    echo "1";
    file_put_contents($log_file, date('Y-m-d H:i:s') . " | ERFOLG: $n GSC an $s_id gutgeschrieben\n", FILE_APPEND | LOCK_EX);
    
} catch (Exception $e) {
    if (isset($db) && $db->inTransaction()) {
        $db->rollBack();
    }
    echo "0";
    file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: " . $e->getMessage() . "\n", FILE_APPEND | LOCK_EX);
}
