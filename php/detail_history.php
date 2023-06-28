<?php 

    $connection = new mysqli("localhost","root","","famillydb");
    $data       = mysqli_query($connection, "select * from tb_keuangan where id_keuangan=".$_GET['id_keuangan']);
    $data       = mysqli_fetch_array($data, MYSQLI_ASSOC);

    echo json_encode($data);