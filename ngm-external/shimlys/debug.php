<?php
echo "Test Start\n";
require_once __DIR__ . '/../../../wp-load.php';
echo "WP loaded\n";
if (isset($wpdb)) {
    echo "DB connected\n";
    $tables = $wpdb->get_col("SHOW TABLES LIKE 'vms_schnittstelle'");
    echo "Tables: " . print_r($tables, true) . "\n";
} else {
    echo "No DB\n";
}
