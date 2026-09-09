<?php
// Page web dynamique - Gestion du stock LINEOR Joaillerie
// Les identifiants sont charges depuis config.php (non versionne, voir config.example.php)
require_once 'config.php';

$conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

if ($conn->connect_error) {
    die("Erreur : " . $conn->connect_error);
}

$sql = "SELECT * FROM produits";
$result = $conn->query($sql);
?>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>LINEOR - Stock</title>
<style>
body{font-family:Arial;background:#1a1a1a;color:#d4af37;}
h1{text-align:center;padding:20px;}
table{width:90%;margin:auto;border-collapse:collapse;}
th{background:#d4af37;color:#1a1a1a;padding:10px;}
td{padding:10px;text-align:center;border-bottom:1px solid #d4af37;}
</style>
</head>
<body>
<h1>LINEOR Joaillerie - Gestion du Stock</h1>
<table>
<tr>
<th>Reference</th><th>Nom</th><th>Materiau</th><th>Prix</th><th>Stock</th><th>Categorie</th>
</tr>
<?php while($row = $result->fetch_assoc()) { ?>
<tr>
<td><?= $row['reference'] ?></td>
<td><?= $row['nom'] ?></td>
<td><?= $row['materiau'] ?></td>
<td><?= $row['prix'] ?> EUR</td>
<td><?= $row['stock'] ?></td>
<td><?= $row['categorie'] ?></td>
</tr>
<?php } ?>
</table>
</body>
</html>
<?php $conn->close(); ?>
