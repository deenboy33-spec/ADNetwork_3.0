# ADNetwork 3.0 - Lokal Entwicklung

## Projekt-Ziel
Saubere Neuimplementierung des ADNetwork-Systems mit:
- CP/GSC Zweikonten-System (CashPoints + GoldSurferCoins)
- Kompatibilität zur originalen Werbeflut-Struktur
- SMI-Schnittstelle für Transfers zu wwdclub.de

## Ausgangslage

### Original Werbeflut (c13werbeflut.sql)
- **Datenbank**: `c13werbeflut` (84 Tabellen, 1.2 GB)
- **Guthaben-System**: Alles in `netzwerk_user` (eine Tabelle)
  - `guthaben` = CP/Guthaben (keine Trennung)
  - `werbeguthaben` = Werbeguthaben
  - `auszahlung` = Auszahlungssumme
  - `einzahlung` = Einzahlungssumme
- **SMI-Schnittstelle**: `netzwerk_schnittstelle` (Shimly, ID=211)
  - Kurs: 1:1000 (Einzahlen: 1.0, Auszahlen: 1000.0)
  - Mindestauszahlung: 1.000.000
  - Passwort: `kRg6kDLC6621dDa4gIuOfpYL8CgBeSJZ`

### Problem ADCityCentral.net (aktuell)
- `vms_*` Tabellen von mir erstellt (nicht original)
- `wp_ngm_user_accounts` LEER (0 Einträge)
- Originalstruktur nicht verwendet

## Lokale Datenbank: `adcitycentral_lokal`

### Importierte Tabellen (Original)
- `netzwerk_schnittstelle` - SMI-Schnittstelle
- `netzwerk_user` - User + Guthaben
- `netzwerk_buchungen` - Buchungen
- `netzwerk_auszahlungen` - Auszahlungen
- `netzwerk_einzahlungen` - Einzahlungen
- `netzwerk_userkonten` - Userkonten (Bank/PayPal)

### Neue Tabellen (CP/GSC)
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

## API-Struktur (SMI)

### Shimly-Schnittstelle
- `send.php` - GSC-Auszahlung (von GSC-Konto)
- `get.php` - GSC-Einzahlung (zu GSC-Konto)
- `check.php` - User-Validierung
- `saldo.php` - Guthaben-Prüfung

### Parameter
- `mi_id` = SMI-ID (z.B. 3 für wwdclub)
- `mi_pw` = SMI-Passwort
- `s_id` = User-Login
- `s_pw` = User-Passwort
- `n` = Betrag
- `s` = Buchungstext
- `code` = Sicherheitscode

## Verzeichnisstruktur (geplant)

```
ADNetwork_3.0/
├── database/
│   ├── original/          # Importierte Werbeflut-Tabellen
│   ├── schema/            # Neue Tabellen (CP/GSC)
│   └── migrations/        # Upgrade-Scripts
├── api/
│   ├── smi/
│   │   ├── send.php       # GSC-Auszahlung
│   │   ├── get.php        # GSC-Einzahlung
│   │   ├── check.php      # User-Validierung
│   │   └── saldo.php      # Guthaben-Prüfung
│   └── internal/
│       ├── cp-earn.php    # CP verdienen
│       ├── cp-convert.php # CP→GSC Umwandlung
│       └── gsc-transfer.php # GSC Transfer
├── frontend/
│   ├── konto/             # Kontobereich
│   ├── cp-shop/           # CP-Shop
│   └── gsc-market/        # GSC-Marktplatz
├── admin/
│   ├── dashboard/         # Admin-Dashboard
│   ├── settings/          # Einstellungen
│   └── reports/           # Berichte
└── docs/
    ├── api.md             # API-Dokumentation
    ├── database.md        # DB-Dokumentation
    └── flowcharts/        # Flowcharts
```

## Nächste Schritte
1. ✅ Lokale Datenbank erstellen
2. ✅ Originale Tabellen importieren
3. ⏳ Neue CP/GSC Tabellen erstellen
4. ⏳ API-Scripts schreiben
5. ⏳ Frontend-Grundstruktur
6. ⏳ Testen mit wwdclub.de
7. ⏳ Online deployen

---
Erstellt: 2026-06-14
Autor: GoldSurfer
