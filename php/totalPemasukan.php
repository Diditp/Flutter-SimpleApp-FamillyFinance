<?php


$connection = new mysqli("localhost","root","","famillydb");
$data       = mysqli_query($connection, "SELECT SUM(pemasukan) as totalpemasukan FROM tb_keuangan");
$data       = mysqli_fetch_all($data, MYSQLI_ASSOC);

echo json_encode($data);
