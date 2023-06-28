<?php

    $connection = new mysqli("localhost", "root", "", "famillydb");
    $id_user = $_POST['id_user'];
    $nama      = $_POST['nama']; 
    $ket      = $_POST['keterangan']; 
    $income    = $_POST['pemasukan'];    
    $outCome    = $_POST['pengeluaran'];    
    $date       = $_POST['tanggal'];
    $result = mysqli_query($connection, "INSERT INTO `tb_keuangan`(`id_keuangan`, `id_user`, `nama`, `tanggal`, `keterangan`, `pemasukan`, `pengeluaran`) VALUES ('', '$id_user','$nama','$date','$ket','$income', '$outCome')");
    
    if($result){
        echo json_encode([
            'message' => 'Data input successfully'
        ]);
    }else{
        echo json_encode([
            'message' => 'Data Failed to input'
        ]);
    }