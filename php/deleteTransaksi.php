<?php

    $connection = new mysqli("localhost", "root", "", "famillydb");

    $id_keuangan = $_GET['id_keuangan'];

    $result = mysqli_query($connection, "delete from tb_keuangan where id_keuangan=".$id_keuangan);

    if($result){
        echo json_encode([
            'message' => 'Data delete successfully'
        ]);
    }else{
        echo json_encode([
            'message' => 'Data Failed to delete'
        ]);
    }