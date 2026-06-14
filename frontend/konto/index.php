<?php
/**
 * ADNetwork 3.0 - Member Kontobereich
 * User sieht CP/GSC und kann Umwandlungen machen
 */

require_once __DIR__ . '/../../config/database.php';

session_start();

// Demo: Eingeloggt als jogibernd
// Später: Login-System mit Sessions
$current_user = $_SESSION['user'] ?? 'jogibernd';

$db = getDatabaseConnection();

// User-Daten laden
$stmt = $db->prepare("SELECT u.*, c.cp_balance, c.cp_gesamt, c.cp_ausgegeben, g.gsc_balance, g.gsc_gesamt, g.gsc_ausgegeben FROM netzwerk_user u LEFT JOIN netzwerk_cp_konten c ON c.userid = u.userid LEFT JOIN netzwerk_gsc_konten g ON g.userid = u.userid WHERE u.nickname = ?");
$stmt->execute([$current_user]);
$user = $stmt->fetch();

if (!$user) {
    die("User nicht gefunden");
}

// Letzte Transfers
$stmt = $db->prepare("SELECT * FROM netzwerk_gsc_transfers WHERE userid = ? ORDER BY zeit DESC LIMIT 5");
$stmt->execute([$user['userid']]);
$transfers = $stmt->fetchAll();

// Letzte Umwandlungen
$stmt = $db->prepare("SELECT * FROM netzwerk_cp_gsc_umwandlung WHERE userid = ? ORDER BY zeit DESC LIMIT 5");
$stmt->execute([$user['userid']]);
$umwandlungen = $stmt->fetchAll();

// Letzte CP-Verdienste
$stmt = $db->prepare("SELECT * FROM netzwerk_cp_earnings WHERE userid = ? ORDER BY zeit DESC LIMIT 5");
$stmt->execute([$user['userid']]);
$earnings = $stmt->fetchAll();

?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mein Konto - ADNetwork 3.0</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #eee;
            min-height: 100vh;
        }
        .container { max-width: 1000px; margin: 0 auto; padding: 20px; }
        
        .header {
            text-align: center;
            padding: 40px 20px;
            background: rgba(0,0,0,0.2);
            border-radius: 15px;
            margin-bottom: 30px;
        }
        .header h1 { color: #e94560; font-size: 2.5em; margin-bottom: 10px; }
        .header p { color: #888; font-size: 1.1em; }
        .user-badge {
            display: inline-block;
            background: #e94560;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            margin-top: 15px;
            font-weight: 600;
        }
        
        .konto-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .konto-card {
            background: #16213e;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .konto-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 4px;
        }
        .konto-card.cp::before { background: #0f3460; }
        .konto-card.gsc::before { background: #ffd700; }
        
        .konto-icon {
            font-size: 3em;
            margin-bottom: 15px;
        }
        .konto-card.cp .konto-icon { color: #4fc3f7; }
        .konto-card.gsc .konto-icon { color: #ffd700; }
        
        .konto-label { color: #888; text-transform: uppercase; letter-spacing: 2px; font-size: 0.9em; }
        .konto-balance { font-size: 3em; font-weight: bold; margin: 15px 0; }
        .konto-card.cp .konto-balance { color: #4fc3f7; }
        .konto-card.gsc .konto-balance { color: #ffd700; }
        
        .konto-stats {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #333;
        }
        .stat-box { text-align: center; }
        .stat-box .value { font-size: 1.2em; font-weight: bold; color: #fff; }
        .stat-box .label { font-size: 0.8em; color: #888; margin-top: 5px; }
        
        .actions {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 30px;
        }
        .btn {
            padding: 18px 25px;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }
        .btn-convert {
            background: #16c79a;
            color: #000;
        }
        .btn-convert:hover { background: #1ee0a5; transform: translateY(-2px); }
        .btn-transfer {
            background: #e94560;
            color: #fff;
        }
        .btn-transfer:hover { background: #ff6b6b; transform: translateY(-2px); }
        .btn-earn {
            background: #0f3460;
            color: #4fc3f7;
            grid-column: span 2;
        }
        .btn-earn:hover { background: #1a4a7a; transform: translateY(-2px); }
        
        .section {
            background: #16213e;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
        }
        .section h2 {
            color: #e94560;
            margin-bottom: 20px;
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
        
        .kurs-info {
            background: rgba(255,215,0,0.1);
            border: 1px solid #ffd700;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            margin-bottom: 20px;
        }
        .kurs-info span { color: #ffd700; font-weight: bold; font-size: 1.2em; }
        
        @media (max-width: 768px) {
            .konto-grid { grid-template-columns: 1fr; }
            .actions { grid-template-columns: 1fr; }
            .btn-earn { grid-column: span 1; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏄‍♂️ Mein Konto</h1>
            <p>Verwalte deine CashPoints und GoldSurferCoins</p>
            <div class="user-badge">👤 <?= htmlspecialchars($user['nickname']) ?></div>
        </div>
        
        <div class="kurs-info">
            💱 Aktueller Kurs: <span>1.000 CP = 1 GSC</span> (1:1000)
        </div>
        
        <div class="konto-grid">
            <div class="konto-card cp">
                <div class="konto-icon">💰</div>
                <div class="konto-label">CashPoints</div>
                <div class="konto-balance"><?= number_format($user['cp_balance'] ?? 0, 0) ?></div>
                <div class="konto-stats">
                    <div class="stat-box">
                        <div class="value"><?= number_format($user['cp_gesamt'] ?? 0, 0) ?></div>
                        <div class="label">Gesamt</div>
                    </div>
                    <div class="stat-box">
                        <div class="value"><?= number_format($user['cp_ausgegeben'] ?? 0, 0) ?></div>
                        <div class="label">Ausgegeben</div>
                    </div>
                </div>
            </div>
            
            <div class="konto-card gsc">
                <div class="konto-icon">🪙</div>
                <div class="konto-label">GoldSurferCoins</div>
                <div class="konto-balance"><?= number_format($user['gsc_balance'] ?? 0, 0) ?></div>
                <div class="konto-stats">
                    <div class="stat-box">
                        <div class="value"><?= number_format($user['gsc_gesamt'] ?? 0, 0) ?></div>
                        <div class="label">Gesamt</div>
                    </div>
                    <div class="stat-box">
                        <div class="value"><?= number_format($user['gsc_ausgegeben'] ?? 0, 0) ?></div>
                        <div class="label">Ausgegeben</div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="actions">
            <a href="convert.php" class="btn btn-convert">💱 CP → GSC umwandeln</a>
            <a href="transfer.php" class="btn btn-transfer">🚀 GSC transferieren</a>
            <a href="earn.php" class="btn btn-earn">📢 Werbung abrufen & CP verdienen</a>
        </div>
        
        <div class="section">
            <h2>🔄 Letzte Transfers</h2>
            <?php if (empty($transfers)): ?>
                <p style="color: #888;">Noch keine Transfers</p>
            <?php else: ?>
                <table>
                    <thead>
                        <tr><th>Datum</th><th>Partner</th><th>Betrag</th><th>Status</th></tr>
                    </thead>
                    <tbody>
                        <?php foreach ($transfers as $t): ?>
                        <tr>
                            <td><?= date('d.m.Y H:i', $t['zeit']) ?></td>
                            <td><?= htmlspecialchars($t['smi_name']) ?></td>
                            <td><?= number_format($t['betrag'], 0) ?> GSC</td>
                            <td><span class="status-badge status-<?= $t['status'] ?>"><?= ucfirst($t['status']) ?></span></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php endif; ?>
        </div>
        
        <div class="section">
            <h2>💱 Letzte Umwandlungen</h2>
            <?php if (empty($umwandlungen)): ?>
                <p style="color: #888;">Noch keine Umwandlungen</p>
            <?php else: ?>
                <table>
                    <thead>
                        <tr><th>Datum</th><th>CP</th><th>GSC</th><th>Kurs</th><th>Status</th></tr>
                    </thead>
                    <tbody>
                        <?php foreach ($umwandlungen as $u): ?>
                        <tr>
                            <td><?= date('d.m.Y H:i', $u['zeit']) ?></td>
                            <td><?= number_format($u['cp_betrag'], 0) ?></td>
                            <td><?= number_format($u['gsc_betrag'], 2) ?></td>
                            <td>1:<?= $u['kurs'] ?></td>
                            <td><span class="status-badge status-<?= $u['status'] ?>"><?= ucfirst($u['status']) ?></span></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php endif; ?>
        </div>
        
        <div class="section">
            <h2>📊 Letzte Verdienste</h2>
            <?php if (empty($earnings)): ?>
                <p style="color: #888;">Noch keine Verdienste</p>
            <?php else: ?>
                <table>
                    <thead>
                        <tr><th>Datum</th><th>Quelle</th><th>Betrag</th></tr>
                    </thead>
                    <tbody>
                        <?php foreach ($earnings as $e): ?>
                        <tr>
                            <td><?= date('d.m.Y H:i', $e['zeit']) ?></td>
                            <td><?= htmlspecialchars($e['quelle']) ?></td>
                            <td>+<?= number_format($e['cp_betrag'], 0) ?> CP</td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php endif; ?>
        </div>
    </div>
</body>
</html>
