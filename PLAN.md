# ADCityCentral 3.0 - Kompletter Plan

## Ausgangslage (Werbeflut-Original)

### Datenbank: `netzwerk_*` Tabellen (84 Tabellen, 1.2 GB)

**Wichtigste Tabellen:**
- `netzwerk_user` - User + Guthaben (alles in einer Tabelle!)
- `netzwerk_schnittstelle` - SMI-Schnittstelle (Shimly, ID=211)
- `netzwerk_buchungen` - Buchungen
- `netzwerk_auszahlungen` - Auszahlungen
- `netzwerk_einzahlungen` - Einzahlungen

**Guthaben-System (Werbeflut):**
- `guthaben` = CP/Guthaben (keine Trennung!)
- `werbeguthaben` = Werbeguthaben
- `auszahlung` = Auszahlungssumme
- `einzahlung` = Einzahlungssumme

**SMI-Schnittstelle (Shimly):**
- `betreiber_id` = 211
- `betreiber_passwort` = `kRg6kDLC6621dDa4gIuOfpYL8CgBeSJZ`
- `kurs_ein` = 1.0
- `kurs_aus` = 1000.0 (1:1000!)
- `auszahlsumme` = 1.000.000 (Mindestauszahlung!)

## Problem: ADCityCentral.net hat eine andere Struktur!

### Aktuelle ADCityCentral.net Struktur (von mir kaputt gemacht):
- `wp_ngm_user_accounts` - LEER (0 Einträge)
- `vms_konten` - VON MIR ERSTELLT (nicht original!)
- `vms_schnittstelle` - VON MIR ERSTELLT (nicht original!)
- `vms_schnittstelle_buchungen` - VON MIR ERSTELLT (nicht original!)

### Was passiert aktuell:
1. wwdclub.de ruft API auf mit `mi_id=3`
2. API prüft `vms_schnittstelle` (von mir erstellt)
3. API prüft `vms_konten` (von mir erstellt)
4. Guthaben wird in `vms_konten` gutgeschrieben
5. ABER: `wp_ngm_user_accounts` ist LEER!

## Lösung: Lokale Version 3.0

### Schritt 1: Lokale Datenbank erstellen
```sql
CREATE DATABASE adcitycentral_lokal;
```

### Schritt 2: Tabellen aus Werbeflut importieren
- `netzwerk_schnittstelle` (Original)
- `netzwerk_user` (Original)
- `netzwerk_buchungen` (Original)
- `netzwerk_auszahlungen` (Original)
- `netzwerk_einzahlungen` (Original)
- `netzwerk_userkonten` (Original)

### Schritt 3: Neue Tabellen für CP/GSC erstellen
```sql
-- CP-Konto (CashPoints)
CREATE TABLE netzwerk_cp_konten (
    userid INT PRIMARY KEY,
    cp_balance DECIMAL(20,8) DEFAULT 0,
    cp_gesamt DECIMAL(20,8) DEFAULT 0,
    FOREIGN KEY (userid) REFERENCES netzwerk_user(userid)
);

-- GSC-Konto (GoldSurferCoins)
CREATE TABLE netzwerk_gsc_konten (
    userid INT PRIMARY KEY,
    gsc_balance DECIMAL(20,8) DEFAULT 0,
    gsc_gesamt DECIMAL(20,8) DEFAULT 0,
    FOREIGN KEY (userid) REFERENCES netzwerk_user(userid)
);

-- CP-GSC Umwandlung
CREATE TABLE netzwerk_cp_gsc_umwandlung (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userid INT,
    cp_betrag DECIMAL(20,8),
    gsc_betrag DECIMAL(20,8),
    kurs DECIMAL(10,4),
    zeit INT,
    FOREIGN KEY (userid) REFERENCES netzwerk_user(userid)
);
```

### Schritt 4: API anpassen
- `send.php` - GSC-Auszahlung (von GSC-Konto)
- `get.php` - GSC-Einzahlung (zu GSC-Konto)
- `check.php` - User-Validierung
- `saldo.php` - Guthaben-Prüfung

### Schritt 5: CP-Verdienst-System
- Mitglieder verdienen CP (CashPoints)
- CP können in GSC umgewandelt werden
- GSC können zu wwdclub.de transferiert werden

## Ziel:
- Saubere Trennung CP/GSC
- Kompatibel mit Werbeflut-System
- Einfache Umwandlung CP→GSC
- Transfer zu wwdclub.de möglich

## Nächste Schritte:
1. Lokale DB vorbereiten
2. Tabellen erstellen
3. API anpassen
4. Testen
5. Online deployen

---
Erstellt: 2026-06-14
