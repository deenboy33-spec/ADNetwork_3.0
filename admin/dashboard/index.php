<?php
/**
 * ADNetwork 3.0 - Admin Dashboard
 * Zentrale Übersicht für Bernd
 */

require_once __DIR__ . '/../config/database.php';

$db = getDatabaseConnection();

// Statistiken abfragen
$stats = [];

// Gesamt-User
$stmt = $db->query("SELECT COUNT(*) as total FROM netzwerk_user WHERE status = 1");
$stats['total_users'] = $stmt->fetch()['total'];

// Aktive User (heute)
$heute = strtotime('today midnight');
$stmt = $db->query("SELECT COUNT(DISTINCT userid) as active FROM netzwerk_cp_earnings WHERE zeit >= $heute");
$stats['active_today'] = $stmt->fetch()['active'];

// CP im Umlauf
$stmt = $db->query("SELECT SUM(cp_balance) as total, SUM(cp_gesamt) as gesamt FROM netzwerk_cp_konten");
$cp = $stmt->fetch();
$stats['cp_total'] = $cp['total'] ?? 0;
$stats['cp_gesamt'] = $cp['gesamt'] ?? 0;

// GSC im Umlauf
$stmt = $db->query("SELECT SUM(gsc_balance) as total, SUM(gsc_gesamt) as gesamt FROM netzwerk_gsc_konten");
$gsc = $stmt->fetch();
$stats['gsc_total'] = $gsc['total'] ?? 0;
$stats['gsc_gesamt'] = $gsc['gesamt'] ?? 0;

// Heutige Transfers
$stmt = $db->query("SELECT COUNT(*) as count, SUM(betrag) as betrag FROM netzwerk_gsc_transfers WHERE zeit >= $heute AND status = 'completed'");
$transfers = $stmt->fetch();
$stats['transfers_today'] = $transfers['count'] ?? 0;
$stats['transfers_betrag'] = $transfers['betrag'] ?? 0;

// Heutige Umwandlungen
$stmt = $db->query("SELECT COUNT(*) as count, SUM(cp_betrag) as cp, SUM(gsc_betrag) as gsc FROM netzwerk_cp_gsc_umwandlung WHERE zeit >= $heute AND status = 'completed'");
$umwandlungen = $stmt->fetch();
$stats['umw_count'] = $umwandlungen['count'] ?? 0;
$stats['umw_cp'] = $umwandlungen['cp'] ?? 0;
$stats['umw_gsc'] = $umwandlungen['gsc'] ?? 0;

// Letzte 10 Transfers
$stmt = $db->query("SELECT t.*, u.nickname FROM netzwerk_gsc_transfers t LEFT JOIN netzwerk_user u ON u.userid = t.userid ORDER BY t.zeit DESC LIMIT 10");
$letzte_transfers = $stmt->fetchAll();

// Top 10 User nach CP
$stmt = $db->query("SELECT u.nickname, c.cp_balance, c.cp_gesamt FROM netzwerk_cp_konten c LEFT JOIN netzwerk_user u ON u.userid = c.userid ORDER BY c.cp_balance DESC LIMIT 10");
$top_cp = $stmt->fetchAll();

// Top 10 User nach GSC
$stmt = $db->query("SELECT u.nickname, g.gsc_balance, g.gsc_gesamt FROM netzwerk_gsc_konten g LEFT JOIN netzwerk_user u ON u.userid = g.userid ORDER BY g.gsc_balance DESC LIMIT 10");
$top_gsc = $stmt->fetchAll();

?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADNetwork 3.0 - Admin Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #1a1a2e;
            color: #eee;
            line-height: 1.6;
        }
        .container { max-width: 1400px; margin: 0 auto; padding: 20px; }
        h1 { color: #e94560; margin-bottom: 10px; }
        .subtitle { color: #888; margin-bottom: 30px; }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: #16213e;
            border-radius: 10px;
            padding: 20px;
            border-left: 4px solid #e94560;
        }
        .stat-card.blue { border-left-color: #0f3460; }
        .stat-card.green { border-left-color: #16c79a; }
        .stat-card.gold { border-left-color: #ffd700; }
        .stat-card.purple { border-left-color: #a855f7; }
        .stat-label { color: #888; font-size: 0.9em; text-transform: uppercase; letter-spacing: 1px; }
        .stat-value { font-size: 2em; font-weight: bold; color: #fff; margin: 10px 0; }
        .stat-sub { color: #aaa; font-size: 0.85em; }
        
        .section {
            background: #16213e;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .section h2 {
            color: #e94560;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #333;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #333;
        }
        th {
            color: #e94560;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85em;
            letter-spacing: 1px;
        }
        tr:hover { background: rgba(233, 69, 96, 0.1); }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }
        .status-completed { background: #16c79a; color: #000; }
        .status-pending { background: #ffd700; color: #000; }
        .status-failed { background: #e94560; color: #fff; }
        
        .two-col {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        @media (max-width: 768px) {
            .two-col { grid-template-columns: 1fr; }
            .stats-grid { grid-template-columns: 1fr; }
        }
        
        .refresh-btn {
            background: #e94560;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            margin-bottom: 20px;
        }
        .refresh-btn:hover { background: #ff6b6b; }
        
        .timestamp {
            color: #666;
            font-size: 0.85em;
            text-align: right;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏄‍♂️ ADNetwork 3.0 Dashboard</h1>
        <p class="subtitle">Zentrale Übersicht — Du siehst alles auf einen Blick</p>
        
        <button class="refresh-btn" onclick="location.reload()">🔄 Aktualisieren</button>
        
        <!-- Hauptstatistiken -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Mitglieder gesamt</div>
                <div class="stat-value"><?= number_format($stats['total_users']) ?></div>
                <div class="stat-sub">Registrierte User</div>
            </div>
            <div class="stat-card green">
                <div class="stat-label">Heute aktiv</div>
                <div class="stat-value"><?= number_format($stats['active_today']) ?></div>
                <div class="stat-sub">User mit Aktivität</div>
            </div>
            <div class="stat-card blue">
                <div class="stat-label">CP im Umlauf</div>
                <div class="stat-value"><?= number_format($stats['cp_total'], 0) ?></div>
                <div class="stat-sub">Gesamt: <?= number_format($stats['cp_gesamt'], 0) ?></div>
            </div>
            <div class="stat-card gold">
                <div class="stat-label">GSC im Umlauf</div>
                <div class="stat-value"><?= number_format($stats['gsc_total'], 0) ?></div>
                <div class="stat-sub">Gesamt: <?= number_format($stats['gsc_gesamt'], 0) ?></div>
            </div>
            <div class="stat-card purple">
                <div class="stat-label">Transfers heute</div>
                <div class="stat-value"><?= number_format($stats['transfers_today']) ?></div>
                <div class="stat-sub"><?= number_format($stats['transfers_betrag'], 0) ?> GSC</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Umwandlungen heute</div>
                <div class="stat-value"><?= number_format($stats['umw_count']) ?></div>
                <div class="stat-sub"><?= number_format($stats['umw_cp'], 0) ?> CP → <?= number_format($stats['umw_gsc'], 0) ?> GSC</div>
            </div>
        </div>
        
        <!-- Zwei Spalten -->
        <div class="two-col">
            <!-- Top CP User -->
            <div class="section">
                <h2>💰 Top CashPoints</h2>
                <table>
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Balance</th>
                            <th>Gesamt</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($top_cp as $user): ?>
                        <tr>
                            <td><?= htmlspecialchars($user['nickname']) ?></td>
                            <td><?= number_format($user['cp_balance'], 0) ?></td>
                            <td><?= number_format($user['cp_gesamt'], 0) ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
            
            <!-- Top GSC User -->
            <div class="section">
                <h2>🪙 Top GoldSurferCoins</h2>
                <table>
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Balance</th>
                            <th>Gesamt</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($top_gsc as $user): ?>
                        <tr>
                            <td><?= htmlspecialchars($user['nickname']) ?></td>
                            <td><?= number_format($user['gsc_balance'], 0) ?></td>
                            <td><?= number_format($user['gsc_gesamt'], 0) ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Letzte Transfers -->
        <div class="section">
            <h2>🔄 Letzte Transfers</h2>
            <table>
                <thead>
                    <tr>
                        <th>Zeit</th>
                        <th>User</th>
                        <th>Partner</th>
                        <th>Betrag</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($letzte_transfers as $t): ?>
                    <tr>
                        <td><?= date('d.m.Y H:i', $t['zeit']) ?></td>
                        <td><?= htmlspecialchars($t['nickname'] ?? 'Unbekannt') ?></td>
                        <td><?= htmlspecialchars($t['smi_name']) ?> (<?= $t['smi_id'] ?>)</td>
                        <td><?= number_format($t['betrag'], 0) ?> GSC</td>
                        <td><span class="status-badge status-<?= $t['status'] ?>"><?= ucfirst($t['status']) ?></span></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        
        <p class="timestamp">Letzte Aktualisierung: <?= date('d.m.Y H:i:s') ?></p>
    </div>
</body>
</html>
