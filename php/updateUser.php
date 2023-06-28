<?php

    $connection = new mysqli("localhost", "root", "", "famillydb");
    $username      = $_POST['username']; 
    $email    = $_POST['email'];    
    $level    = $_POST['levels'];    
    $id_user         = $_POST['id_user'];
    $pass         = $_POST['pass'];
        
    $result = mysqli_query($connection, "UPDATE `tb_users` SET `username` = '$username', `email` = '$email', `pass` = '$pass', `levels` = '$level' WHERE `id_user` =" .$id_user);
        
    if($result){
        echo json_encode([
            'message' => 'Data edit successfully'
        ]);
    }else{
        echo json_encode([
            'message' => 'Data Failed to update'
        ]);
    }