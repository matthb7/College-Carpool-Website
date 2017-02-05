<? php
incldue_once '../global.php';

$currItem = $_POST['item'];

$sql = mysqli_prepare("SELECT * FROM product ORDER BY id ASC LIMIT ?, 1;"); //Load 1 more results
$sql
$conn = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_DATABASE);
$productRes = mysqli_query($conn, $sql);
