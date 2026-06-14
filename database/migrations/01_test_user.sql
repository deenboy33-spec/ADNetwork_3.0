-- ADNetwork 3.0 - Test-User Setup
-- Erstellt Test-User mit CP und GSC Guthaben

-- Test-User: jogibernd
-- Passwort: testpass123 (MD5: 4c9d7f8e8b3a6d2f1e5c0b4a3d2f1e5c - Beispiel)

-- Prüfen, ob User existiert
SELECT userid, nickname FROM netzwerk_user WHERE nickname = 'jogibernd';

-- Falls nicht vorhanden, einen Test-User einfügen (basierend auf originaler Struktur)
INSERT IGNORE INTO netzwerk_user (userid, nickname, werber, status, passwort, ifpasswort, email, guthaben, anmeldezeit, aktivzeit, ip)
VALUES (99999, 'jogibernd', 'admin', 1, 'test_hash', '4c9d7f8e8b3a6d2f1e5c0b4a3d2f1e5c', 'test@adcitycentral.net', 0, UNIX_TIMESTAMP(), 0, '127.0.0.1');

-- CP-Konto erstellen mit Startguthaben
INSERT INTO netzwerk_cp_konten (userid, cp_balance, cp_gesamt, cp_ausgegeben, letzte_aktion)
VALUES (99999, 1000000.00, 1000000.00, 0, UNIX_TIMESTAMP())
ON DUPLICATE KEY UPDATE
    cp_balance = cp_balance + 1000000.00,
    cp_gesamt = cp_gesamt + 1000000.00,
    letzte_aktion = UNIX_TIMESTAMP();

-- GSC-Konto erstellen mit Startguthaben
INSERT INTO netzwerk_gsc_konten (userid, gsc_balance, gsc_gesamt, gsc_ausgegeben, letzte_aktion)
VALUES (99999, 500000.00, 500000.00, 0, UNIX_TIMESTAMP())
ON DUPLICATE KEY UPDATE
    gsc_balance = gsc_balance + 500000.00,
    gsc_gesamt = gsc_gesamt + 500000.00,
    letzte_aktion = UNIX_TIMESTAMP();

-- CP-Verdienst-Log Eintrag
INSERT INTO netzwerk_cp_earnings (userid, quelle, cp_betrag, ref_userid, ref_level, zeit)
VALUES (99999, 'test_setup', 1000000.00, NULL, 0, UNIX_TIMESTAMP());

-- GSC-Transfer-Log (Test)
INSERT INTO netzwerk_gsc_transfers (userid, smi_id, smi_name, betrag, kurs, status, zeit)
VALUES (99999, 3, 'wwdclub', 100000.00, 1000.0000, 'completed', UNIX_TIMESTAMP());

-- Ergebnis prüfen
SELECT u.nickname, u.guthaben, 
       c.cp_balance, c.cp_gesamt,
       g.gsc_balance, g.gsc_gesamt
FROM netzwerk_user u
LEFT JOIN netzwerk_cp_konten c ON c.userid = u.userid
LEFT JOIN netzwerk_gsc_konten g ON g.userid = u.userid
WHERE u.nickname = 'jogibernd';
