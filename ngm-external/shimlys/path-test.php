<?php
echo "DIR: " . __DIR__ . "\n";
echo "File: " . __FILE__ . "\n";
echo "Exists: " . (file_exists(__DIR__ . '/../../../wp-config.php') ? 'YES' : 'NO') . "\n";
$paths = [
    __DIR__ . '/../../../wp-config.php',
    __DIR__ . '/../../wp-config.php',
    __DIR__ . '/../wp-config.php',
    __DIR__ . '/wp-config.php',
    dirname(__DIR__, 3) . '/wp-config.php',
    dirname(__DIR__, 2) . '/wp-config.php',
    dirname(__DIR__, 1) . '/wp-config.php',
];
foreach ($paths as $p) {
    echo $p . " => " . (file_exists($p) ? 'EXISTS' : 'NOT FOUND') . "\n";
}
