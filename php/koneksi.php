<?php 
$connect = new mysqli("localhost","root","","famillydb");
if($connect){
}else{
	echo "Connection Failed";
	exit();
}
 ?>