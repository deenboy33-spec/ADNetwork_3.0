<?php
/**
 * ADNetwork 3.0 - Datenbank-Konfiguration
 * Lokale Entwicklung
 */

// Datenbank-Konfiguration
define('DB_HOST', '127.0.0.1');
define('DB_NAME', 'adcitycentral_lokal');
define('DB_USER', 'root');
define('DB_PASS', ''); // Lokal ohne Passwort (oder anpassen)
define('DB_CHARSET', 'utf8mb4');

// PDO-Verbindung
function getDatabaseConnection() {
    static $pdo = null;
    
    if ($pdo === null) {
        try {
            $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
            $pdo = new PDO($dsn, DB_USER, DB_PASS, [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ]);
        } catch (PDOException $e) {
            error_log("Datenbank-Verbindungsfehler: " . $e->getMessage());
            throw new Exception("Datenbank-Verbindungsfehler");
        }
    }
    
    return $pdo;
}

// Hilfsfunktion: Zeitstempel
function getTimestamp() {
    return time();
}

// Hilfsfunktion: Sicherer Output
function safeOutput($text) {
    return htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
}
