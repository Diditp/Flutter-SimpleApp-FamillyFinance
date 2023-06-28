<?php

    $connection = new mysqli("localhost", "root", "", "famillydb");

if($_SERVER['REQUEST_METHOD'] == "POST"){
    $response = array();
    $username = $_POST['username'];
    $password = $_POST['pass'];
    
    $cek = "SELECT * FROM tb_users WHERE username='$username' AND pass='$password' ";
    $result = mysqli_fetch_array(mysqli_query($connection, $cek));

    if(isset($result)){
        $response['value'] = 1;
        $response['message'] = 'Login Berhasil';
        echo json_encode($response);

    } else{
            $response['value'] = 0;
            $response['message'] = "login gagal";
            echo json_encode($response);
        }
    }

?>