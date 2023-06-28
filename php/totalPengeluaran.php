<?php


$connection = new mysqli("localhost","root","","famillydb");
$data       = mysqli_query($connection, "SELECT SUM(pengeluaran) as totalpengeluaran FROM tb_keuangan");
$data       = mysqli_fetch_all($data, MYSQLI_ASSOC);

echo json_encode($data);
