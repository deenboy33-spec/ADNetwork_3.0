<?php
/**
 * Plugin Name: ADCityCentral Faucet Connector (ADS-Media kompatibel)
 * Description: Shimly-SMI kompatibler Connector für ADCityCentral.net - 100% ADS-Media kompatibel
 * Version: 1.0.0
 * Author: GoldSurfer
 * Text Domain: adcc-faucet
 * License: GPL-2.0+
 * License URI: https://www.gnu.org/licenses/gpl-2.0.html
 */

if (!defined('ABSPATH')) exit;

/**
 * ADCityCentral Faucet Connector - ADS-Media kompatibel
 * 
 * Dieses Plugin ersetzt Shimly.de durch ADCityCentral.net
 * 100% kompatibel mit ADS-Media Faucet-Systemen
 */
class ADCityCentral_Faucet {

    /** API Endpoint */
    const API_BASE = 'https://adcitycentral.net/ngm-external/shimlys/';
    
    /** API Endpoints (Shimly-SMI kompatibel) */
    const API_SEND = 'send.php';         // Auszahlung
    const API_GET = 'get.php';           // Einzahlung
    const API_SALDO = 'saldo.php';       // User-Guthaben
    const API_VALIDATE = 'validate.php'; // User validieren
    const API_SMI_SALDO = 'smi_saldo.php'; // SMI-Guthaben

    /** Error codes (Shimly-SMI kompatibel) */
    const ERROR_CODES = [
        1001 => 'OK',
        1002 => 'SMI Account existiert nicht',
        1003 => 'SMI Passwort falsch',
        1004 => 'Nicht genug freie SMI Anfragen',
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

    /**
     * Get configuration
     */
    public static function get_config() {
        return [
            'enabled'            => (bool) get_option('adcc_enabled', true),
            'deposit_enabled'    => (bool) get_option('adcc_deposit_enabled', false),
            'account'            => get_option('adcc_account', ''),
            'password'           => get_option('adcc_password', ''),
            'exchange_rate'      => (float) get_option('adcc_exchange_rate', '1.0'),
            'exchange_rate_in'   => (float) get_option('adcc_exchange_rate_in', '0'),
            'euro_rate'          => (float) get_option('adcc_euro_rate', '0'),
            'min_payout'         => (float) get_option('adcc_min_payout', '100000'),
            'max_payout'         => (float) get_option('adcc_max_payout', '10000000'),
            'min_deposit'        => (float) get_option('adcc_min_deposit', '0'),
            'base_fee'           => (float) get_option('adcc_base_fee', '0'),
            'trust_level'        => (int) get_option('adcc_trust_level', '0'),
            'daily_requests'     => (int) get_option('adcc_daily_requests', '0'),
            'extra_request_fee'  => (float) get_option('adcc_extra_request_fee', '0'),
            'text_payout'        => get_option('adcc_text_payout', 'GSC Auszahlung'),
            'text_deposit'       => get_option('adcc_text_deposit', 'GSC Einzahlung'),
            'bp_enabled'         => (bool) get_option('adcc_bp_enabled', false),
            'bp_exchange_rate'   => (float) get_option('adcc_bp_exchange_rate', '0'),
            'paidsurf_enabled'   => (bool) get_option('adcc_paidsurf_enabled', false),
            'paidsurf_rate'      => (float) get_option('adcc_paidsurf_rate', '1.5'),
        ];
    }

    /**
     * Request a payout in GSC
     * 
     * @param int|string $user_id User ID oder Username
     * @param float $amount Betrag in GSC
     * @return array|WP_Error
     */
    public static function request_payout($user_id, $amount) {
        $config = self::get_config();

        if (!$config['enabled']) {
            return new WP_Error('disabled', __('Auszahlungen sind deaktiviert.', 'adcc-faucet'));
        }

        if ($amount < $config['min_payout']) {
            return new WP_Error('below_minimum',
                sprintf(__('Mindestauszahlung: %s GSC', 'adcc-faucet'), number_format($config['min_payout'], 0, ',', '.'))
            );
        }

        if ($config['max_payout'] > 0 && $amount > $config['max_payout']) {
            return new WP_Error('above_maximum',
                sprintf(__('Maximalauszahlung: %s GSC', 'adcc-faucet'), number_format($config['max_payout'], 0, ',', '.'))
            );
        }

        // Convert to GSC (1:1 standard)
        $gsc_amount = self::convert_to_gsc($amount);

        // Generate confirmation token
        $token = wp_generate_password(32, false);

        $details = [
            'gsc_amount'    => $gsc_amount,
            'exchange_rate' => $config['exchange_rate'],
            'confirm_token' => $token,
            'confirmed'     => false,
        ];

        return $details;
    }

    /**
     * Send GSC via API (ADS-Media kompatibel)
     * 
     * @param string $adcc_user_id ADCityCentral Username
     * @param string $adcc_user_pw Transfer-Passwort
     * @param float $amount Betrag in GSC
     * @param string $subject Betreff
     * @return array|WP_Error
     */
    public static function send_gsc($adcc_user_id, $adcc_user_pw, $amount, $subject = '') {
        $config = self::get_config();

        if (empty($config['account']) || empty($config['password'])) {
            return new WP_Error('not_configured', __('ADCityCentral Account nicht konfiguriert.', 'adcc-faucet'));
        }

        if (empty($adcc_user_id)) {
            return new WP_Error('no_user_id', __('Kein ADCityCentral User angegeben.', 'adcc-faucet'));
        }

        if (empty($adcc_user_pw)) {
            return new WP_Error('no_password', __('Transfer-Passwort erforderlich.', 'adcc-faucet'));
        }

        if (empty($subject)) {
            $subject = $config['text_payout'] ?: 'GSC Auszahlung';
        }

        // Transaction code
        $trans_code = wp_generate_password(16, false);

        // API call - send.php (ADS-Media kompatibel)
        $api_url = self::API_BASE . self::API_SEND . '?' . http_build_query([
            'mi_id' => $config['account'],
            'mi_pw' => $config['password'],
            's_id'  => $adcc_user_id,
            's_pw'  => $adcc_user_pw,
            's'     => $subject,
            'n'     => $amount,
            'code'  => $trans_code,
        ]);

        $response = wp_remote_get($api_url, [
            'timeout' => 30,
            'headers' => ['Referer' => home_url('/')],
        ]);

        if (is_wp_error($response)) {
            return $response;
        }

        $body = wp_remote_retrieve_body($response);

        // Parse SMI response: "CODE|..." (pipe-delimited)
        $parts = explode('|', $body, 7);
        $smi_code = intval($parts[0] ?? 0);

        if ($smi_code === 1001) {
            return [
                'success'      => true,
                'amount'       => $amount,
                'trans_code'   => $trans_code,
                'user_id'      => $adcc_user_id,
                'smi_code'     => $smi_code,
                'smi_balance'  => floatval($parts[1] ?? 0),
                'user_balance' => floatval($parts[4] ?? 0),
                'response'     => $body,
            ];
        }

        $error_msg = self::ERROR_CODES[$smi_code] ?? ('SMI Code ' . $smi_code);
        return new WP_Error('smi_error', sprintf(__('ADCityCentral Fehler: %s (Code %d)', 'adcc-faucet'), $error_msg, $smi_code));
    }

    /**
     * Test API connection by checking SMI balance (smi_saldo.php)
     * ADS-Media kompatibel
     */
    public static function test_connection() {
        $config = self::get_config();

        if (empty($config['account']) || empty($config['password'])) {
            return new WP_Error('not_configured', __('SMI credentials not configured.', 'adcc-faucet'));
        }

        $api_url = self::API_BASE . self::API_SMI_SALDO . '?' . http_build_query([
            'mi_id' => $config['account'],
            'mi_pw' => $config['password'],
        ]);

        $response = wp_remote_get($api_url, [
            'timeout' => 15,
            'headers' => ['Referer' => home_url('/')],
        ]);

        if (is_wp_error($response)) {
            return $response;
        }

        $body = wp_remote_retrieve_body($response);
        $parts = explode('|', $body, 7);
        $code = intval($parts[0] ?? 0);

        if ($code !== 1001) {
            $error_msg = self::ERROR_CODES[$code] ?? ('Unknown SMI error (Code ' . $code . ')');
            return new WP_Error('smi_error', $error_msg);
        }

        return [
            'smi_balance'  => floatval($parts[1] ?? 0),
            'user_balance' => floatval($parts[2] ?? 0),
        ];
    }

    /**
     * Validate an ADCityCentral user (validate.php)
     * ADS-Media kompatibel
     */
    public static function validate_user($adcc_user_id, $adcc_user_pw = '') {
        $config = self::get_config();

        if (empty($config['account']) || empty($config['password'])) {
            return new WP_Error('not_configured', __('SMI credentials not configured.', 'adcc-faucet'));
        }

        $api_url = self::API_BASE . self::API_VALIDATE . '?' . http_build_query([
            'mi_id' => $config['account'],
            'mi_pw' => $config['password'],
            's_id'  => $adcc_user_id,
            's_pw'  => $adcc_user_pw,
        ]);

        $response = wp_remote_get($api_url, [
            'timeout' => 15,
            'headers' => ['Referer' => home_url('/')],
        ]);

        if (is_wp_error($response)) {
            return $response;
        }

        $body = wp_remote_retrieve_body($response);
        $parts = explode('|', $body, 7);
        $code = intval($parts[0] ?? 0);

        if ($code !== 1001) {
            $error_msg = self::ERROR_CODES[$code] ?? ('SMI error: Code ' . $code);
            return new WP_Error('smi_error', $error_msg);
        }

        return trim($parts[1] ?? ''); // Nickname
    }

    /**
     * Get user's ADCityCentral balance (saldo.php)
     * ADS-Media kompatibel
     */
    public static function get_user_balance($adcc_user_id, $adcc_user_pw) {
        $config = self::get_config();

        if (empty($config['account']) || empty($config['password'])) {
            return new WP_Error('not_configured', __('SMI credentials not configured.', 'adcc-faucet'));
        }

        $api_url = self::API_BASE . self::API_SALDO . '?' . http_build_query([
            'mi_id' => $config['account'],
            'mi_pw' => $config['password'],
            's_id'  => $adcc_user_id,
            's_pw'  => $adcc_user_pw,
        ]);

        $response = wp_remote_get($api_url, [
            'timeout' => 15,
            'headers' => ['Referer' => home_url('/')],
        ]);

        if (is_wp_error($response)) {
            return $response;
        }

        $body = wp_remote_retrieve_body($response);
        $parts = explode('|', $body, 7);
        $code = intval($parts[0] ?? 0);

        if ($code !== 1001) {
            $error_msg = self::ERROR_CODES[$code] ?? ('SMI error: Code ' . $code);
            return new WP_Error('smi_error', $error_msg);
        }

        return floatval($parts[1] ?? 0);
    }

    /**
     * Request deposit: User → Betreiber (get.php)
     * ADS-Media kompatibel
     */
    public static function request_deposit($adcc_user_id, $adcc_user_pw, $amount, $subject = '') {
        $config = self::get_config();

        if (!$config['deposit_enabled']) {
            return new WP_Error('disabled', __('Einzahlungen sind deaktiviert.', 'adcc-faucet'));
        }

        if (empty($config['account']) || empty($config['password'])) {
            return new WP_Error('not_configured', __('SMI credentials not configured.', 'adcc-faucet'));
        }

        if ($config['min_deposit'] > 0 && $amount < $config['min_deposit']) {
            return new WP_Error('below_minimum',
                sprintf(__('Mindesteinzahlung: %s GSC', 'adcc-faucet'), number_format($config['min_deposit'], 0, ',', '.'))
            );
        }

        $trans_code = wp_generate_password(16, false);

        if (empty($subject)) {
            $subject = $config['text_deposit'] ?: 'GSC Einzahlung';
        }

        $api_url = self::API_BASE . self::API_GET . '?' . http_build_query([
            'mi_id' => $config['account'],
            'mi_pw' => $config['password'],
            's_id'  => $adcc_user_id,
            's_pw'  => $adcc_user_pw,
            's'     => $subject,
            'n'     => $amount,
            'code'  => $trans_code,
        ]);

        $response = wp_remote_get($api_url, [
            'timeout' => 30,
            'headers' => ['Referer' => home_url('/')],
        ]);

        if (is_wp_error($response)) {
            return $response;
        }

        $body = wp_remote_retrieve_body($response);
        $parts = explode('|', $body, 7);
        $code = intval($parts[0] ?? 0);

        if ($code === 1001) {
            return true;
        }

        $error_msg = self::ERROR_CODES[$code] ?? ('SMI Code ' . $code);
        return new WP_Error('smi_error', sprintf(__('ADCityCentral Fehler: %s (Code %d)', 'adcc-faucet'), $error_msg, $code));
    }

    /**
     * Get exchange rate: Internal → GSC
     */
    public static function get_exchange_rate() {
        return (float) get_option('adcc_exchange_rate', '1.0');
    }

    /**
     * Convert internal amount to GSC
     */
    public static function convert_to_gsc($amount) {
        $rate = self::get_exchange_rate();
        return round($amount * $rate, 0);
    }

    // ==================== ADMIN INTERFACE ====================

    /**
     * Add admin menu
     */
    public static function admin_menu() {
        add_menu_page(
            'ADCityCentral Faucet',
            'ADCityCentral',
            'manage_options',
            'adcc-faucet',
            [__CLASS__, 'admin_page'],
            'dashicons-money-alt',
            30
        );
    }

    /**
     * Admin settings page
     */
    public static function admin_page() {
        if (isset($_POST['adcc_save'])) {
            check_admin_referer('adcc_faucet_settings');
            
            update_option('adcc_enabled', isset($_POST['enabled']) ? '1' : '0');
            update_option('adcc_deposit_enabled', isset($_POST['deposit_enabled']) ? '1' : '0');
            update_option('adcc_account', sanitize_text_field($_POST['account']));
            update_option('adcc_password', sanitize_text_field($_POST['password']));
            update_option('adcc_exchange_rate', floatval($_POST['exchange_rate']));
            update_option('adcc_exchange_rate_in', floatval($_POST['exchange_rate_in']));
            update_option('adcc_euro_rate', floatval($_POST['euro_rate']));
            update_option('adcc_min_payout', floatval($_POST['min_payout']));
            update_option('adcc_max_payout', floatval($_POST['max_payout']));
            update_option('adcc_min_deposit', floatval($_POST['min_deposit']));
            update_option('adcc_base_fee', floatval($_POST['base_fee']));
            update_option('adcc_trust_level', intval($_POST['trust_level']));
            update_option('adcc_daily_requests', intval($_POST['daily_requests']));
            update_option('adcc_extra_request_fee', floatval($_POST['extra_request_fee']));
            update_option('adcc_text_payout', sanitize_text_field($_POST['text_payout']));
            update_option('adcc_text_deposit', sanitize_text_field($_POST['text_deposit']));
            update_option('adcc_bp_enabled', isset($_POST['bp_enabled']) ? '1' : '0');
            update_option('adcc_bp_exchange_rate', floatval($_POST['bp_exchange_rate']));
            update_option('adcc_paidsurf_enabled', isset($_POST['paidsurf_enabled']) ? '1' : '0');
            update_option('adcc_paidsurf_rate', floatval($_POST['paidsurf_rate']));
            
            echo '<div class="updated"><p><strong>Einstellungen gespeichert!</strong></p></div>';
        }

        $config = self::get_config();
        ?>
        <div class="wrap">
            <h1>🏄‍♂️ ADCityCentral Faucet Connector</h1>
            <p>Shimly-SMI kompatibel — Sendet GSC zu ADCityCentral.net</p>
            
            <hr>
            
            <h2>🔧 SMI-Einstellungen</h2>
            <form method="post">
                <?php wp_nonce_field('adcc_faucet_settings'); ?>
                
                <table class="form-table">
                    <tr>
                        <th><label>Status</label></th>
                        <td>
                            <label><input type="checkbox" name="enabled" <?php checked($config['enabled']); ?>> Auszahlungen aktiv</label><br>
                            <label><input type="checkbox" name="deposit_enabled" <?php checked($config['deposit_enabled']); ?>> Einzahlungen aktiv</label>
                        </td>
                    </tr>
                    <tr>
                        <th><label>SMI Account</label></th>
                        <td><input type="text" name="account" value="<?php echo esc_attr($config['account']); ?>" class="regular-text" placeholder="Dein ADCityCentral Account"></td>
                    </tr>
                    <tr>
                        <th><label>SMI Passwort</label></th>
                        <td><input type="password" name="password" value="<?php echo esc_attr($config['password']); ?>" class="regular-text"></td>
                    </tr>
                    <tr>
                        <th><label>Exchange Rate</label></th>
                        <td>
                            <input type="number" step="0.0001" name="exchange_rate" value="<?php echo esc_attr($config['exchange_rate']); ?>" class="small-text">
                            <span class="description">(1:1 = 1.0, z.B. 1000 Punkte = 1000 GSC)</span>
                        </td>
                    </tr>
                    <tr>
                        <th><label>Min. Auszahlung</label></th>
                        <td><input type="number" name="min_payout" value="<?php echo esc_attr($config['min_payout']); ?>" class="regular-text"> GSC</td>
                    </tr>
                    <tr>
                        <th><label>Max. Auszahlung</label></th>
                        <td><input type="number" name="max_payout" value="<?php echo esc_attr($config['max_payout']); ?>" class="regular-text"> GSC (0 = unbegrenzt)</td>
                    </tr>
                    <tr>
                        <th><label>Min. Einzahlung</label></th>
                        <td><input type="number" name="min_deposit" value="<?php echo esc_attr($config['min_deposit']); ?>" class="regular-text"> GSC</td>
                    </tr>
                    <tr>
                        <th><label>Betreff Auszahlung</label></th>
                        <td><input type="text" name="text_payout" value="<?php echo esc_attr($config['text_payout']); ?>" class="regular-text"></td>
                    </tr>
                    <tr>
                        <th><label>Betreff Einzahlung</label></th>
                        <td><input type="text" name="text_deposit" value="<?php echo esc_attr($config['text_deposit']); ?>" class="regular-text"></td>
                    </tr>
                    <tr>
                        <th><label>Basis-Gebühr</label></th>
                        <td><input type="number" step="0.01" name="base_fee" value="<?php echo esc_attr($config['base_fee']); ?>" class="small-text"> GSC</td>
                    </tr>
                    <tr>
                        <th><label>Trust Level</label></th>
                        <td><input type="number" name="trust_level" value="<?php echo esc_attr($config['trust_level']); ?>" class="small-text"></td>
                    </tr>
                    <tr>
                        <th><label>Tägliche Anfragen</label></th>
                        <td><input type="number" name="daily_requests" value="<?php echo esc_attr($config['daily_requests']); ?>" class="small-text"> (0 = unbegrenzt)</td>
                    </tr>
                    <tr>
                        <th><label>Extra-Gebühr</label></th>
                        <td><input type="number" step="0.01" name="extra_request_fee" value="<?php echo esc_attr($config['extra_request_fee']); ?>" class="small-text"> GSC</td>
                    </tr>
                    <tr>
                        <th><label>Paidsurf</label></th>
                        <td>
                            <label><input type="checkbox" name="paidsurf_enabled" <?php checked($config['paidsurf_enabled']); ?>> Aktiv</label>
                            <input type="number" step="0.1" name="paidsurf_rate" value="<?php echo esc_attr($config['paidsurf_rate']); ?>" class="small-text"> Rate
                        </td>
                    </tr>
                    <tr>
                        <th><label>BoostPoints</label></th>
                        <td>
                            <label><input type="checkbox" name="bp_enabled" <?php checked($config['bp_enabled']); ?>> Aktiv</label>
                            <input type="number" step="0.0001" name="bp_exchange_rate" value="<?php echo esc_attr($config['bp_exchange_rate']); ?>" class="small-text"> Rate
                        </td>
                    </tr>
                </table>
                
                <p><input type="submit" name="adcc_save" class="button-primary" value="💾 Speichern"></p>
            </form>

            <hr>
            
            <h2>🧪 Verbindung testen</h2>
            <?php if (!empty($config['account'])) :
                $balance = self::test_connection();
                if (!is_wp_error($balance)) : ?>
                    <p style="color: green;">✅ <strong>Verbunden!</strong></p>
                    <p>Betreiber-Guthaben: <strong><?php echo number_format($balance['smi_balance'], 0, ',', '.'); ?></strong> GSC</p>
                    <p>Gesamt-User-Guthaben: <strong><?php echo number_format($balance['user_balance'], 0, ',', '.'); ?></strong> GSC</p>
                <?php else : ?>
                    <p style="color: red;">❌ <strong>Verbindungsfehler:</strong> <?php echo esc_html($balance->get_error_message()); ?></p>
                    <p>Prüfe SMI-Zugangsdaten und API-URL.</p>
                <?php endif; ?>
            <?php else : ?>
                <p>⚠️ Trage SMI-Zugangsdaten ein und speichere.</p>
            <?php endif; ?>

            <hr>
            
            <h2>📖 API-Informationen</h2>
            <p><strong>API-URL:</strong> <code><?php echo self::API_BASE; ?></code></p>
            <p><strong>Format:</strong> Shimly-SMI kompatibel (pipe-delimited)</p>
            <p><strong>Mindestauszahlung:</strong> 100.000 GSC</p>
            <p><strong>Transfer-Passwort:</strong> Erforderlich für jede Auszahlung</p>
            
            <h3>API-Endpunkte</h3>
            <table class="widefat">
                <thead>
                    <tr><th>Endpoint</th><th>Beschreibung</th></tr>
                </thead>
                <tbody>
                    <tr><td><code>send.php</code></td><td>Auszahlung senden</td></tr>
                    <tr><td><code>get.php</code></td><td>Einzahlung empfangen</td></tr>
                    <tr><td><code>saldo.php</code></td><td>User-Guthaben prüfen</td></tr>
                    <tr><td><code>validate.php</code></td><td>User validieren</td></tr>
                    <tr><td><code>smi_saldo.php</code></td><td>SMI-Guthaben prüfen</td></tr>
                </tbody>
            </table>
        </div>
        <?php
    }

    /**
     * Add settings link on plugins page
     */
    public static function plugin_action_links($links) {
        $settings_link = '<a href="' . admin_url('admin.php?page=adcc-faucet') . '">Einstellungen</a>';
        array_unshift($links, $settings_link);
        return $links;
    }
}

// Init
add_action('admin_menu', ['ADCityCentral_Faucet', 'admin_menu']);
add_filter('plugin_action_links_' . plugin_basename(__FILE__), ['ADCityCentral_Faucet', 'plugin_action_links']);

// ==================== AJAX HANDLER ====================

add_action('wp_ajax_adcc_payout', function() {
    check_ajax_referer('adcc_payout_nonce', 'nonce');
    
    $user_id = sanitize_text_field($_POST['adcc_user'] ?? '');
    $user_pw = sanitize_text_field($_POST['adcc_pw'] ?? '');
    $amount = floatval($_POST['amount'] ?? 0);
    $subject = sanitize_text_field($_POST['subject'] ?? '');

    $result = ADCityCentral_Faucet::send_gsc($user_id, $user_pw, $amount, $subject);
    
    if (is_wp_error($result)) {
        wp_send_json_error($result->get_error_message());
    } else {
        wp_send_json_success($result);
    }
});

add_action('wp_ajax_adcc_validate', function() {
    check_ajax_referer('adcc_payout_nonce', 'nonce');
    
    $user_id = sanitize_text_field($_POST['adcc_user'] ?? '');
    $user_pw = sanitize_text_field($_POST['adcc_pw'] ?? '');

    $result = ADCityCentral_Faucet::validate_user($user_id, $user_pw);
    
    if (is_wp_error($result)) {
        wp_send_json_error($result->get_error_message());
    } else {
        wp_send_json_success(['nickname' => $result]);
    }
});

add_action('wp_ajax_adcc_balance', function() {
    check_ajax_referer('adcc_payout_nonce', 'nonce');
    
    $user_id = sanitize_text_field($_POST['adcc_user'] ?? '');
    $user_pw = sanitize_text_field($_POST['adcc_pw'] ?? '');

    $result = ADCityCentral_Faucet::get_user_balance($user_id, $user_pw);
    
    if (is_wp_error($result)) {
        wp_send_json_error($result->get_error_message());
    } else {
        wp_send_json_success(['balance' => $result]);
    }
});

// ==================== SHORTCODES ====================

/**
 * Shortcode: [adcc_faucet_form] - Zeigt Auszahlungsformular
 */
add_shortcode('adcc_faucet_form', function($atts) {
    if (!is_user_logged_in()) {
        return '<p>Bitte einloggen um Auszahlungen zu tätigen.</p>';
    }
    
    ob_start();
    ?>
    <div class="adcc-faucet-form">
        <h3>💰 GSC Auszahlung</h3>
        <form id="adcc-payout-form">
            <?php wp_nonce_field('adcc_payout_nonce', 'adcc_nonce'); ?>
            <p>
                <label>ADCityCentral Username:</label><br>
                <input type="text" name="adcc_user" required placeholder="z.B. jogibernd">
            </p>
            <p>
                <label>Transfer-Passwort:</label><br>
                <input type="password" name="adcc_pw" required>
            </p>
            <p>
                <label>Betrag (GSC):</label><br>
                <input type="number" name="amount" min="100000" required placeholder="Mindestens 100000">
            </p>
            <p>
                <button type="submit" class="button">Auszahlung beantragen</button>
            </p>
            <div id="adcc-result"></div>
        </form>
    </div>
    <script>
    jQuery(document).ready(function($) {
        $('#adcc-payout-form').on('submit', function(e) {
            e.preventDefault();
            var data = {
                action: 'adcc_payout',
                nonce: $('#adcc_nonce').val(),
                adcc_user: $('input[name="adcc_user"]').val(),
                adcc_pw: $('input[name="adcc_pw"]').val(),
                amount: $('input[name="amount"]').val()
            };
            $.post('<?php echo admin_url('admin-ajax.php'); ?>', data, function(response) {
                if (response.success) {
                    $('#adcc-result').html('<p style="color:green;">✅ Erfolg! ' + response.data.amount + ' GSC gesendet.</p>');
                } else {
                    $('#adcc-result').html('<p style="color:red;">❌ Fehler: ' + response.data + '</p>');
                }
            });
        });
    });
    </script>
    <?php
    return ob_get_clean();
});

// ==================== ACTIVATION/DEACTIVATION ====================

register_activation_hook(__FILE__, function() {
    // Default settings
    add_option('adcc_enabled', true);
    add_option('adcc_deposit_enabled', false);
    add_option('adcc_account', '');
    add_option('adcc_password', '');
    add_option('adcc_exchange_rate', '1.0');
    add_option('adcc_min_payout', '100000');
    add_option('adcc_max_payout', '10000000');
    add_option('adcc_text_payout', 'GSC Auszahlung');
    add_option('adcc_text_deposit', 'GSC Einzahlung');
});

register_deactivation_hook(__FILE__, function() {
    // Cleanup if needed
});
