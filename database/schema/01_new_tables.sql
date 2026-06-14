-- ADNetwork 3.0 - Neue Tabellen (CP/GSC System)
-- Diese Tabellen erweitern die originalen Werbeflut-Tabellen

-- CP-Konto (CashPoints)
-- Mitglieder verdienen CP durch Surfen, Klicks, etc.
CREATE TABLE IF NOT EXISTS netzwerk_cp_konten (
    userid INT NOT NULL,
    cp_balance DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    cp_gesamt DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    cp_ausgegeben DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    letzte_aktion INT NOT NULL DEFAULT 0,
    PRIMARY KEY (userid),
    FOREIGN KEY (userid) REFERENCES netzwerk_user(userid) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- GSC-Konto (GoldSurferCoins)
-- GSC werden durch CP-Umwandlung oder direkte Einzahlung erhalten
CREATE TABLE IF NOT EXISTS netzwerk_gsc_konten (
    userid INT NOT NULL,
    gsc_balance DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    gsc_gesamt DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    gsc_ausgegeben DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    letzte_aktion INT NOT NULL DEFAULT 0,
    PRIMARY KEY (userid),
    FOREIGN KEY (userid) REFERENCES netzwerk_user(userid) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- CP-GSC Umwandlung-Log
-- Jede Umwandlung von CP zu GSC wird hier protokolliert
CREATE TABLE IF NOT EXISTS netzwerk_cp_gsc_umwandlung (
    id INT NOT NULL AUTO_INCREMENT,
    userid INT NOT NULL,
    cp_betrag DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    gsc_betrag DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    kurs DECIMAL(10,4) NOT NULL DEFAULT 1000.0000,
    gebuehr DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    status ENUM('pending', 'completed', 'cancelled') NOT NULL DEFAULT 'pending',
    zeit INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    FOREIGN KEY (userid) REFERENCES netzwerk_user(userid) ON DELETE CASCADE,
    INDEX idx_zeit (zeit),
    INDEX idx_userid (userid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- GSC-Transfer-Log (nach extern)
-- Transfers zu wwdclub.de oder anderen SMI-Partnern
CREATE TABLE IF NOT EXISTS netzwerk_gsc_transfers (
    id INT NOT NULL AUTO_INCREMENT,
    userid INT NOT NULL,
    smi_id INT NOT NULL DEFAULT 0,
    smi_name VARCHAR(50) NOT NULL DEFAULT '',
    betrag DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    kurs DECIMAL(10,4) NOT NULL DEFAULT 1000.0000,
    status ENUM('pending', 'completed', 'failed', 'cancelled') NOT NULL DEFAULT 'pending',
    fehlercode VARCHAR(50) DEFAULT NULL,
    fehlertext VARCHAR(255) DEFAULT NULL,
    zeit INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    FOREIGN KEY (userid) REFERENCES netzwerk_user(userid) ON DELETE CASCADE,
    INDEX idx_zeit (zeit),
    INDEX idx_userid (userid),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- CP-Verdienst-Log
-- Wie wurden CP verdient?
CREATE TABLE IF NOT EXISTS netzwerk_cp_earnings (
    id INT NOT NULL AUTO_INCREMENT,
    userid INT NOT NULL,
    quelle VARCHAR(50) NOT NULL DEFAULT '',
    cp_betrag DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    ref_userid INT DEFAULT NULL,
    ref_level INT DEFAULT 0,
    zeit INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    FOREIGN KEY (userid) REFERENCES netzwerk_user(userid) ON DELETE CASCADE,
    INDEX idx_zeit (zeit),
    INDEX idx_userid (userid),
    INDEX idx_quelle (quelle)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- SMI-Schnittstellen-Partner
-- Erweiterte Partner-Verwaltung (basierend auf netzwerk_schnittstelle)
CREATE TABLE IF NOT EXISTS netzwerk_smi_partner (
    id INT NOT NULL AUTO_INCREMENT,
    smi_id INT NOT NULL DEFAULT 0,
    name VARCHAR(100) NOT NULL DEFAULT '',
    passwort VARCHAR(255) NOT NULL DEFAULT '',
    kennung VARCHAR(50) NOT NULL DEFAULT '',
    typ VARCHAR(20) NOT NULL DEFAULT 'shimly',
    kurs_ein DECIMAL(25,10) NOT NULL DEFAULT 1.0000000000,
    kurs_aus DECIMAL(25,10) NOT NULL DEFAULT 1000.0000000000,
    min_einzahlung INT NOT NULL DEFAULT 10000,
    min_auszahlung INT NOT NULL DEFAULT 1000000,
    aktiv TINYINT(1) NOT NULL DEFAULT 1,
    letzte_anfrage INT NOT NULL DEFAULT 0,
    letzter_betrag DECIMAL(20,8) NOT NULL DEFAULT 0.00000000,
    PRIMARY KEY (id),
    UNIQUE KEY uk_smi_id (smi_id),
    INDEX idx_aktiv (aktiv)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Trigger: CP-Verdienst aktualisiert CP-Balance
DELIMITER //
CREATE TRIGGER IF NOT EXISTS trg_cp_earnings_insert
AFTER INSERT ON netzwerk_cp_earnings
FOR EACH ROW
BEGIN
    INSERT INTO netzwerk_cp_konten (userid, cp_balance, cp_gesamt, letzte_aktion)
    VALUES (NEW.userid, NEW.cp_betrag, NEW.cp_betrag, NEW.zeit)
    ON DUPLICATE KEY UPDATE
        cp_balance = cp_balance + NEW.cp_betrag,
        cp_gesamt = cp_gesamt + NEW.cp_betrag,
        letzte_aktion = NEW.zeit;
END//
DELIMITER ;

-- Trigger: CP→GSC Umwandlung aktualisiert beide Konten
DELIMITER //
CREATE TRIGGER IF NOT EXISTS trg_cp_gsc_umwandlung_insert
AFTER INSERT ON netzwerk_cp_gsc_umwandlung
FOR EACH ROW
BEGIN
    IF NEW.status = 'completed' THEN
        -- CP abziehen
        UPDATE netzwerk_cp_konten 
        SET cp_balance = cp_balance - NEW.cp_betrag,
            cp_ausgegeben = cp_ausgegeben + NEW.cp_betrag,
            letzte_aktion = NEW.zeit
        WHERE userid = NEW.userid;
        
        -- GSC gutschreiben
        INSERT INTO netzwerk_gsc_konten (userid, gsc_balance, gsc_gesamt, letzte_aktion)
        VALUES (NEW.userid, NEW.gsc_betrag, NEW.gsc_betrag, NEW.zeit)
        ON DUPLICATE KEY UPDATE
            gsc_balance = gsc_balance + NEW.gsc_betrag,
            gsc_gesamt = gsc_gesamt + NEW.gsc_betrag,
            letzte_aktion = NEW.zeit;
    END IF;
END//
DELIMITER ;

-- Trigger: GSC-Transfer aktualisiert GSC-Balance
DELIMITER //
CREATE TRIGGER IF NOT EXISTS trg_gsc_transfer_insert
AFTER INSERT ON netzwerk_gsc_transfers
FOR EACH ROW
BEGIN
    IF NEW.status = 'completed' THEN
        UPDATE netzwerk_gsc_konten 
        SET gsc_balance = gsc_balance - NEW.betrag,
            gsc_ausgegeben = gsc_ausgegeben + NEW.betrag,
            letzte_aktion = NEW.zeit
        WHERE userid = NEW.userid;
    END IF;
END//
DELIMITER ;
