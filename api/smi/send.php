<?php
/**
 * ADNetwork 3.0 - SMI Send API
 * GSC-Auszahlung an externen Partner (z.B. wwdclub.de)
 * 
 * Parameter:
 * - mi_id = SMI-ID des Partners
 * - mi_pw = SMI-Passwort des Partners
 * - s_id = User-Login (oder User-ID)
 * - s_pw = User-Passwort (oder API-Token)
 * - n = Betrag in GSC
 * - s = Buchungstext
 * - code = Sicherheitscode (optional)
 * 
 * Rückgabe:
 * - Erfolg: 1
 * - Fehler: 0
 */

header('Content-Type: text/plain; charset=utf-8');

// Konfiguration laden
require_once __DIR__ . '/../../config/database.php';

// Parameter validieren
$mi_id = isset($_GET['mi_id']) ? intval($_GET['mi_id']) : 0;
$mi_pw = isset($_GET['mi_pw']) ? $_GET['mi_pw'] : '';
$s_id = isset($_GET['s_id']) ? $_GET['s_id'] : '';
$s_pw = isset($_GET['s_pw']) ? $_GET['s_pw'] : '';
$n = isset($_GET['n']) ? floatval($_GET['n']) : 0;
$buchungstext = isset($_GET['s']) ? $_GET['s'] : 'GSC Transfer';
$code = isset($_GET['code']) ? $_GET['code'] : '';

// Logging
$log_file = __DIR__ . '/../../logs/smi_send.log';
$log_entry = date('Y-m-d H:i:s') . " | Send API | mi_id=$mi_id | s_id=$s_id | n=$n | code=$code\n";
file_put_contents($log_file, $log_entry, FILE_APPEND | LOCK_EX);

// Validierung
if ($mi_id <= 0 || empty($mi_pw) || empty($s_id) || empty($n)) {
    echo "0";
    file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: Fehlende Parameter\n", FILE_APPEND | LOCK_EX);
    exit;
}

try {
    $db = getDatabaseConnection();
    
    // 1. Partner validieren (SMI-Schnittstelle)
    $stmt = $db->prepare("
        SELECT sp.*, s.kurs_aus, s.ineuro 
        FROM netzwerk_smi_partner sp
        LEFT JOIN netzwerk_schnittstelle s ON s.schnittstelle = 'shimly'
        WHERE sp.smi_id = ? AND sp.passwort = ? AND sp.aktiv = 1
    ");
    $stmt->execute([$mi_id, $mi_pw]);
    $partner = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$partner) {
        // Fallback: Original-Tabelle prüfen
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
        SELECT u.userid, u.nickname, u.passwort, u.ifpasswort, u.status, u.guthaben
        FROM netzwerk_user u
        WHERE u.nickname = ?
    ");
    $stmt->execute([$s_id]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$user || $user['status'] != 1) {
        echo "0";
        file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: User nicht gefunden oder inaktiv\n", FILE_APPEND | LOCK_EX);
        exit;
    }
    
    // Passwort prüfen (MD5 oder Hash)
    $pw_valid = false;
    if (strlen($s_pw) == 32 && $s_pw == $user['ifpasswort']) {
        $pw_valid = true; // MD5-Hash (Interface-Passwort)
    } elseif (strlen($user['passwort']) == 64 && hash('sha256', $s_pw) == $user['passwort']) {
        $pw_valid = true; // SHA-256
    } elseif (md5($s_pw) == $user['ifpasswort']) {
        $pw_valid = true; // MD5 direkt
    }
    
    if (!$pw_valid) {
        echo "0";
        file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: Passwort ungültig\n", FILE_APPEND | LOCK_EX);
        exit;
    }
    
    // 3. GSC-Guthaben prüfen
    $stmt = $db->prepare("SELECT gsc_balance FROM netzwerk_gsc_konten WHERE userid = ?");
    $stmt->execute([$user['userid']]);
    $gsc_konto = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$gsc_konto || $gsc_konto['gsc_balance'] < $n) {
        echo "0";
        file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: Nicht genug GSC (vorhanden: " . ($gsc_konto['gsc_balance'] ?? 0) . ", benötigt: $n)\n", FILE_APPEND | LOCK_EX);
        exit;
    }
    
    // 4. Mindestauszahlung prüfen
    $min_auszahlung = $partner['min_auszahlung'] ?? 1000000;
    if ($n < $min_auszahlung) {
        echo "0";
        file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: Betrag zu niedrig (min: $min_auszahlung)\n", FILE_APPEND | LOCK_EX);
        exit;
    }
    
    // 5. Transfer durchführen
    $db->beginTransaction();
    
    // GSC abziehen
    $stmt = $db->prepare("
        UPDATE netzwerk_gsc_konten 
        SET gsc_balance = gsc_balance - ?, 
            gsc_ausgegeben = gsc_ausgegeben + ?,
            letzte_aktion = UNIX_TIMESTAMP()
        WHERE userid = ? AND gsc_balance >= ?
    ");
    $stmt->execute([$n, $n, $user['userid'], $n]);
    
    if ($stmt->rowCount() == 0) {
        $db->rollBack();
        echo "0";
        file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: GSC-Update fehlgeschlagen\n", FILE_APPEND | LOCK_EX);
        exit;
    }
    
    // Transfer loggen
    $stmt = $db->prepare("
        INSERT INTO netzwerk_gsc_transfers 
        (userid, smi_id, smi_name, betrag, kurs, status, zeit)
        VALUES (?, ?, ?, ?, ?, 'completed', UNIX_TIMESTAMP())
    ");
    $stmt->execute([
        $user['userid'], 
        $mi_id, 
        $partner['name'] ?? $partner['betreiber_nick'] ?? 'Unbekannt',
        $n, 
        $partner['kurs_aus'] ?? 1000
    ]);
    
    $db->commit();
    
    // Erfolg
    echo "1";
    file_put_contents($log_file, date('Y-m-d H:i:s') . " | ERFOLG: $n GSC an $s_id übertragen\n", FILE_APPEND | LOCK_EX);
    
} catch (Exception $e) {
    if (isset($db) && $db->inTransaction()) {
        $db->rollBack();
    }
    echo "0";
    file_put_contents($log_file, date('Y-m-d H:i:s') . " | FEHLER: " . $e->getMessage() . "\n", FILE_APPEND | LOCK_EX);
}
