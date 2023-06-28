<?php

    $connection = new mysqli("localhost", "root", "", "famillydb");
    $username      = $_POST['username']; 
    $email      = $_POST['email']; 
    $pass    = $_POST['pass'];    
    $level    = $_POST['levels'];    
    // $date       = date('Y-m-d');
    
    $result = mysqli_query($connection, "INSERT INTO `tb_users`(`id_user`, `username`, `email`, `pass`, `levels`) VALUES ('','$username','$email','$pass','$level')");
    
    if($result){
        echo json_encode([
            'message' => 'Data input successfully'
        ]);
    }else{
        echo json_encode([
            'message' => 'Data Failed to input'
        ]);
    }