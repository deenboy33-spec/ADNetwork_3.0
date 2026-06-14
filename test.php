<?php
/**
 * ADCityCentral Faucet Connector Test
 * Mit echten Zugangsdaten für Gold-Surfer-Faucet.de
 */

// Verhindere Auto-Test
define('ADCC_SKIP_AUTO_TEST', true);

define('ADCC_API_BASE', 'https://adcitycentral.net/ngm-external/shimlys/');
define('ADCC_SMI_ACCOUNT', 'gold-surfer-faucet');
define('ADCC_SMI_PASSWORD', 'GSF-2026-ADCC');

require_once 'adcitycentral-faucet-standalone.php';

echo "=== ADCityCentral Faucet Connector Test ===\n\n";

// 1. SMI-Guthaben prüfen
echo "1. SMI-Guthaben prüfen:\n";
$saldo = adcc_smi_saldo();
if ($saldo['success']) {
    echo "   ✅ Betreiber-Guthaben: " . number_format($saldo['smi_balance'], 0, ',', '.') . " GSC\n";
    echo "   ✅ Gesamt-User-Guthaben: " . number_format($saldo['user_balance'], 0, ',', '.') . " GSC\n\n";
} else {
    echo "   ❌ Fehler: Code " . $saldo['code'] . "\n\n";
}

// 2. User validieren
echo "2. User validieren (jogibernd):\n";
$check = adcc_validate_user('jogibernd', 'testpass123');
if ($check['valid']) {
    echo "   ✅ User gültig!\n";
    echo "   ✅ Nickname: " . $check['nickname'] . "\n";
    echo "   ✅ Guthaben: " . number_format($check['balance'], 0, ',', '.') . " GSC\n\n";
} else {
    echo "   ❌ Fehler: " . $check['message'] . " (Code: " . $check['code'] . ")\n\n";
}

// 3. User-Guthaben prüfen
echo "3. User-Guthaben prüfen:\n";
$balance = adcc_user_balance('jogibernd', 'testpass123');
if ($balance['success']) {
    echo "   ✅ Guthaben: " . number_format($balance['balance'], 0, ',', '.') . " GSC\n\n";
} else {
    echo "   ❌ Fehler: Code " . $balance['code'] . "\n\n";
}

// Test-Auszahlung
echo "4. Auszahlung testen (100.000 GSC):\n";
// Wir verwenden s_pw Parameter statt tpw für ADS-Media Kompatibilität
$result = adcc_send('jogibernd', 100000, 'testpass123', 'Gold-Surfer-Faucet Test');
if ($result['success']) {
    echo "   ✅ Auszahlung erfolgreich!\n";
    echo "   ✅ Betrag: " . number_format($result['amount'], 0, ',', '.') . " GSC\n";
    echo "   ✅ Transaktionscode: " . $result['trans_code'] . "\n";
    echo "   ✅ Neues SMI-Guthaben: " . number_format($result['smi_balance'], 0, ',', '.') . " GSC\n";
    echo "   ✅ Neues User-Guthaben: " . number_format($result['user_balance'], 0, ',', '.') . " GSC\n\n";
} else {
    echo "   ❌ Fehler: " . $result['message'] . " (Code: " . $result['code'] . ")\n\n";
}

// 5. Neues Guthaben prüfen
echo "5. Neues Guthaben prüfen:\n";
$saldo2 = adcc_smi_saldo();
if ($saldo2['success']) {
    echo "   ✅ SMI-Guthaben: " . number_format($saldo2['smi_balance'], 0, ',', '.') . " GSC\n";
}
$balance2 = adcc_user_balance('jogibernd', 'testpass123');
if ($balance2['success']) {
    echo "   ✅ User-Guthaben: " . number_format($balance2['balance'], 0, ',', '.') . " GSC\n";
}

echo "\n=== Test abgeschlossen ===\n";