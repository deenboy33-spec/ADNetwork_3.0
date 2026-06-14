<?php
/**
 * ADCityCentral Faucet Integration (Standalone)
 * Version: 1.0
 *
 * Für Faucet-Systeme die Shimly-SMI nutzen.
 * Diese Datei nach ADCityCentral.net umleiten.
 *
 * Installation:
 * 1. Datei auf den Server laden (z.B. /adcc-faucet.php)
 * 2. Zugangsdaten unten eintragen
 * 3. In Faucet-System einbinden: require_once('/pfad/zu/adcc-faucet.php');
 */

// ==== KONFIGURATION ====
define('ADCC_API_URL', 'https://adcitycentral.net/ngm-external/shimlys/send.php');
define('ADCC_SMI_ACCOUNT', '');   // SMI Account-Name
define('ADCC_SMI_PASSWORD', '');  // SMI Passwort
// ==== ENDE KONFIGURATION ====

/**
 * Sendet GSC zu ADCityCentral.net
 * 
 * @param string $adcc_user   ADCityCentral Username (z.B. "jogibernd")
 * @param float  $amount      Betrag in GSC
 * @param string $tpw         Transfer-Passwort des Users
 * @param string $subject     Transaktionsbetreff
 * @return array             ['success' => bool, 'code' => int, 'message' => string]
 */
function adcc_send($adcc_user, $amount, $tpw = '', $subject = 'Faucet Auszahlung') {
    if (empty(ADCC_SMI_ACCOUNT) || empty(ADCC_SMI_PASSWORD)) {
        return ['success' => false, 'code' => 0, 'message' => 'SMI nicht konfiguriert'];
    }

    if (empty($adcc_user)) {
        return ['success' => false, 'code' => 0, 'message' => 'Kein ADCityCentral User angegeben'];
    }

    if ($amount < 100000) {
        return ['success' => false, 'code' => 0, 'message' => 'Mindestauszahlung: 100.000 GSC'];
    }

    $trans_code = bin2hex(random_bytes(8));

    $url = ADCC_API_URL . '?' . http_build_query([
        'mi_id' => ADCC_SMI_ACCOUNT,
        'mi_pw' => ADCC_SMI_PASSWORD,
        's_id'  => $adcc_user,
        's'     => $subject,
        'n'     => $amount,
        'code'  => $trans_code,
        'tpw'   => $tpw,
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

    // Error codes (Shimly-SMI kompatibel)
    $errors = [
        1001 => 'OK',
        1002 => 'Account existiert nicht',
        1003 => 'Passwort falsch',
        1004 => 'Nicht genug freie Anfragen',
        1005 => 'Kennung existiert nicht',
        1006 => 'User existiert nicht',
        1007 => 'User gesperrt',
        1008 => 'User zu geringer Kontostand',
        1009 => 'User Passwort falsch',
        1010 => 'Account zu geringer Kontostand',
        1011 => 'Ungültiger Buchungsbetrag',
        1012 => 'Betreff nicht zulässig',
        1050 => 'Ungültige IP-Adresse',
        1095 => 'Wartungsmodus',
        1097 => 'Überlastet',
        1098 => 'Account gesperrt',
        1099 => 'Unbekannter Fehler',
    ];

    if ($code === 1001) {
        return [
            'success'    => true,
            'code'       => $code,
            'message'    => 'Auszahlung erfolgreich',
            'trans_code' => $trans_code,
            'amount'     => $amount,
            'user'       => $adcc_user,
        ];
    }

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
function adcc_check_user($adcc_user, $tpw = '') {
    $url = str_replace('send.php', 'check.php', ADCC_API_URL) . '?' . http_build_query([
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

    return ['valid' => false, 'code' => $code, 'message' => 'User nicht gefunden'];
}

/**
 * Prüft Betreiber-Guthaben (SMI Saldo)
 * @return array
 */
function adcc_saldo() {
    $url = str_replace('send.php', 'saldo.php', ADCC_API_URL) . '?' . http_build_query([
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

// ==== AUTO-TEST ====
if (php_sapi_name() === 'cli' || isset($_GET['adcc_test'])) {
    echo "ADCityCentral Faucet Integration Test\n";
    echo "=====================================\n\n";
    
    if (empty(ADCC_SMI_ACCOUNT)) {
        echo "⚠️  SMI Account nicht konfiguriert!\n";
        echo "Bearbeite diese Datei und trage Zugangsdaten ein.\n";
        exit(1);
    }

    $saldo = adcc_saldo();
    if ($saldo['success']) {
        echo "✅ SMI verbunden!\n";
        echo "   Betreiber-Guthaben: " . number_format($saldo['smi_balance'], 0, ',', '.') . " GSC\n";
        echo "   User-Guthaben: " . number_format($saldo['user_balance'], 0, ',', '.') . " GSC\n\n";
        
        echo "Funktionen verfügbar:\n";
        echo "  adcc_send(\$user, \$amount, \$tpw, \$subject) - Auszahlung senden\n";
        echo "  adcc_check_user(\$user, \$tpw) - User validieren\n";
        echo "  adcc_saldo() - Guthaben prüfen\n";
    } else {
        echo "❌ Verbindungsfehler: Code " . $saldo['code'] . "\n";
    }
    exit(0);
}
