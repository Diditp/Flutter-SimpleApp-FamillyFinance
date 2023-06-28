<?php

    $connection = new mysqli("localhost", "root", "", "famillydb");
    $nama      = $_POST['nama']; 
    $tanggal    = $_POST['tanggal'];    
    $keterangan    = $_POST['keterangan'];   
    $pemasukan    = $_POST['pemasukan'];   
    $pengeluaran    = $_POST['pengeluaran'];   
    $update_at    = $_POST['update_at'];   
    $id_keuangan         = $_POST['id_keuangan'];
        
    $result = mysqli_query($connection, "UPDATE `tb_keuangan` SET `nama` = '$nama', `tanggal` = '$tanggal', `keterangan` = '$keterangan', `pemasukan` = '$pemasukan', `pengeluaran` = '$pengeluaran', `update_at` = '$update_at'  WHERE `id_keuangan` =" .$id_keuangan);
        
    if($result){
        echo json_encode([
            'message' => 'Data edit successfully'
        ]);
    }else{
        echo json_encode([
            'message' => 'Data Failed to update'
        ]);
    }