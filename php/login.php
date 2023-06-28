<?php 
include 'koneksi.php';

$username = $_POST['username'];
$password = $_POST['pass'];


$queryResult=$connect->query("SELECT * FROM tb_users WHERE username='$username' AND pass='$password' ");

$result=array();
while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
}
echo json_encode($result);
 ?>