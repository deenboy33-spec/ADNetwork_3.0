<?php
/**
 * ADCityCentral Faucet Connector (Standalone)
 * ADS-Media / Shimly-SMI kompatibel
 * Version: 1.0.0
 * 
 * Für Faucet-Systeme, Bonus-Systeme, etc.
 * Einfach per require_once() einbinden
 */

// ==== KONFIGURATION (HIER EINTRAGEN) ====
if (!defined('ADCC_API_BASE')) {
    define('ADCC_API_BASE', 'https://adcitycentral.net/ngm-external/shimlys/');
}
if (!defined('ADCC_SMI_ACCOUNT')) {
    define('ADCC_SMI_ACCOUNT', '');   // Dein SMI Account
}
if (!defined('ADCC_SMI_PASSWORD')) {
    define('ADCC_SMI_PASSWORD', '');  // Dein SMI Passwort
}
// ==== ENDE KONFIGURATION ====

/**
 * Sendet GSC zu ADCityCentral.net (ADS-Media kompatibel)
 * 
 * @param string $adcc_user   ADCityCentral Username (z.B. "jogibernd")
 * @param float  $amount      Betrag in GSC (mindestens 100000)
 * @param string $tpw         Transfer-Passwort des Users
 * @param string $subject     Transaktionsbetreff
 * @return array             ['success' => bool, 'code' => int, 'message' => string, ...]
 */
function adcc_send($adcc_user, $amount, $tpw = '', $subject = 'Faucet Auszahlung') {
    if (empty(ADCC_SMI_ACCOUNT) || empty(ADCC_SMI_PASSWORD)) {
        return ['success' => false, 'code' => 0, 'message' => 'SMI nicht konfiguriert'];
    }

    if (empty($adcc_user)) {
        return ['success' => false, 'code' => 0, 'message' => 'Kein ADCityCentral User angegeben'];
    }

    if (empty($tpw)) {
        return ['success' => false, 'code' => 1009, 'message' => 'Transfer-Passwort erforderlich'];
    }

    if ($amount < 100000) {
        return ['success' => false, 'code' => 1011, 'message' => 'Mindestauszahlung: 100.000 GSC'];
    }

    $trans_code = bin2hex(random_bytes(8));

    $url = ADCC_API_BASE . 'send.php?' . http_build_query([
        'mi_id' => ADCC_SMI_ACCOUNT,
        'mi_pw' => ADCC_SMI_PASSWORD,
        's_id'  => $adcc_user,
        's_pw'  => $tpw,
        's'     => $subject,
        'n'     => $amount,
        'code'  => $trans_code,
    ]);

    $ch = curl_init();
    curl_setopt_array($ch, [
        CURLOPT_URL            => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 30,
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_REFERER        => $_SERVER['HTTP_HOST'] ?? 'localhost',
    ]);

    $response = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($response === false || $http_code !== 200) {
        return ['success' => false, 'code' => 0, 'message' => 'Verbindungsfehler (HTTP ' . $http_code . ')'];
    }

    $parts = explode('|', $response, 7);
    $code = intval($parts[0] ?? 0);

    if ($code === 1001) {
        return [
            'success'      => true,
            'code'         => $code,
            'message'      => 'Auszahlung erfolgreich',
            'trans_code'   => $trans_code,
            'amount'       => $amount,
            'user'         => $adcc_user,
            'smi_balance'  => floatval($parts[1] ?? 0),
            'user_balance' => floatval($parts[4] ?? 0),
        ];
    }

    $errors = [
        1002 => 'SMI Account existiert nicht',
        1003 => 'SMI Passwort falsch',
        1004 => 'Nicht genug freie Anfragen',
        1005 => 'SMI Kennung existiert nicht',
        1006 => 'Shimly User existiert nicht',
        1007 => 'Shimly User gesperrt',
        1008 => 'Shimly User zu geringer Kontostand',
        1009 => 'Shimly User SMI Passwort falsch',
        1010 => 'SMI Account zu geringer Kontostand',
        1011 => 'Ungültiger Buchungsbetrag',
        1012 => 'Betreff nicht zulässig',
        1050 => 'Ungültige IP-Adresse',
        1095 => 'SMI im Wartungsmodus',
        1097 => 'SMI überlastet',
        1098 => 'SMI Account gesperrt',
        1099 => 'Unbekannter Fehler',
    ];

    return [
        'success' => false,
        'code'    => $code,
        'message' => $errors[$code] ?? 'Unbekannter Fehler (Code ' . $code . ')',
        'raw'     => $response,
    ];
}

/**
 * Prüft ADCityCentral User
 * 
 * @param string $adcc_user  Username
 * @param string $tpw        Transfer-Passwort (optional)
 * @return array
 */
function adcc_validate_user($adcc_user, $tpw = '') {
    $url = ADCC_API_BASE . 'validate.php?' . http_build_query([
        'mi_id' => ADCC_SMI_ACCOUNT,
        'mi_pw' => ADCC_SMI_PASSWORD,
        's_id'  => $adcc_user,
        's_pw'  => $tpw,
    ]);

    $ch = curl_init();
    curl_setopt_array($ch, [
        CURLOPT_URL            => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 15,
        CURLOPT_SSL_VERIFYPEER => true,
    ]);

    $response = curl_exec($ch);
    curl_close($ch);

    if ($response === false) {
        return ['valid' => false, 'message' => 'Verbindungsfehler'];
    }

    $parts = explode('|', $response, 7);
    $code = intval($parts[0] ?? 0);

    if ($code === 1001) {
        return [
            'valid'    => true,
            'nickname' => trim($parts[1] ?? ''),
            'balance'  => floatval($parts[2] ?? 0),
        ];
    }

    return ['valid' => false, 'code' => $code, 'message' => 'User nicht gefunden oder Passwort falsch'];
}

/**
 * Prüft User-Guthaben
 * 
 * @param string $adcc_user  Username
 * @param string $tpw        Transfer-Passwort
 * @return array
 */
function adcc_user_balance($adcc_user, $tpw) {
    $url = ADCC_API_BASE . 'saldo.php?' . http_build_query([
        'mi_id' => ADCC_SMI_ACCOUNT,
        'mi_pw' => ADCC_SMI_PASSWORD,
        's_id'  => $adcc_user,
        's_pw'  => $tpw,
    ]);

    $ch = curl_init();
    curl_setopt_array($ch, [
        CURLOPT_URL            => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 15,
        CURLOPT_SSL_VERIFYPEER => true,
    ]);

    $response = curl_exec($ch);
    curl_close($ch);

    if ($response === false) {
        return ['success' => false, 'message' => 'Verbindungsfehler'];
    }

    $parts = explode('|', $response, 7);
    $code = intval($parts[0] ?? 0);

    if ($code === 1001) {
        return [
            'success' => true,
            'balance' => floatval($parts[1] ?? 0),
        ];
    }

    return ['success' => false, 'code' => $code];
}

/**
 * Prüft SMI-Betreiber-Guthaben
 * @return array
 */
function adcc_smi_saldo() {
    $url = ADCC_API_BASE . 'smi_saldo.php?' . http_build_query([
        'mi_id' => ADCC_SMI_ACCOUNT,
        'mi_pw' => ADCC_SMI_PASSWORD,
    ]);

    $ch = curl_init();
    curl_setopt_array($ch, [
        CURLOPT_URL            => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 15,
        CURLOPT_SSL_VERIFYPEER => true,
    ]);

    $response = curl_exec($ch);
    curl_close($ch);

    if ($response === false) {
        return ['success' => false, 'message' => 'Verbindungsfehler'];
    }

    $parts = explode('|', $response, 7);
    $code = intval($parts[0] ?? 0);

    if ($code === 1001) {
        return [
            'success'      => true,
            'smi_balance'  => floatval($parts[1] ?? 0),
            'user_balance' => floatval($parts[2] ?? 0),
        ];
    }

    return ['success' => false, 'code' => $code];
}

// ==== AUTO-TEST (nur CLI oder ?adcc_test=1) ====
if ((!defined('ADCC_SKIP_AUTO_TEST') || !ADCC_SKIP_AUTO_TEST) && (php_sapi_name() === 'cli' || isset($_GET['adcc_test']))) {
    echo "ADCityCentral Faucet Connector - ADS-Media kompatibel\n";
    echo "=====================================================\n\n";
    
    if (empty(ADCC_SMI_ACCOUNT)) {
        echo "⚠️  SMI Account nicht konfiguriert!\n";
        echo "Bearbeite diese Datei und trage Zugangsdaten ein.\n";
        exit(1);
    }

    echo "✅ SMI Account konfiguriert: " . ADCC_SMI_ACCOUNT . "\n\n";

    $saldo = adcc_smi_saldo();
    if ($saldo['success']) {
        echo "✅ SMI verbunden!\n";
        echo "   Betreiber-Guthaben: " . number_format($saldo['smi_balance'], 0, ',', '.') . " GSC\n";
        echo "   Gesamt-User-Guthaben: " . number_format($saldo['user_balance'], 0, ',', '.') . " GSC\n\n";
        
        echo "Funktionen verfügbar:\n";
        echo "  adcc_send(\$user, \$amount, \$tpw, \$subject)     - Auszahlung senden\n";
        echo "  adcc_validate_user(\$user, \$tpw)                  - User validieren\n";
        echo "  adcc_user_balance(\$user, \$tpw)                  - User-Guthaben prüfen\n";
        echo "  adcc_smi_saldo()                                  - SMI-Guthaben prüfen\n";
    } else {
        echo "❌ Verbindungsfehler: Code " . $saldo['code'] . "\n";
    }
    exit(0);
}
