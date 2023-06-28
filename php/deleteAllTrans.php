<?php

    $connection = new mysqli("localhost", "root", "", "famillydb");

    $result = mysqli_query($connection, "delete from tb_keuangan");

    if($result){
        echo json_encode([
            'message' => 'Data delete successfully'
        ]);
    }else{
        echo json_encode([
            'message' => 'Data Failed to delete'
        ]);
    }