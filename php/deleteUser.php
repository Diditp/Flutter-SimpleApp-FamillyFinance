<?php

    $connection = new mysqli("localhost", "root", "", "famillydb");

    $id_user = $_GET['id_user'];

    $result = mysqli_query($connection, "delete from tb_users where id_user=".$id_user);

    if($result){
        echo json_encode([
            'message' => 'Data delete successfully'
        ]);
    }else{
        echo json_encode([
            'message' => 'Data Failed to delete'
        ]);
    }