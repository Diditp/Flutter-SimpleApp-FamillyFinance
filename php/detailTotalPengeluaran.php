<?php

$connection = new mysqli("localhost","root","","famillydb");
$data       = mysqli_query($connection, "SELECT SUM(pengeluaran) as totalPengeluaranUser FROM tb_keuangan WHERE id_user=".$_GET['id_user']);
$data       = mysqli_fetch_all($data, MYSQLI_ASSOC);

echo json_encode($data);
