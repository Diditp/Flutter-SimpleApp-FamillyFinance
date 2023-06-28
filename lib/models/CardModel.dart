// ignore_for_file: file_names

import 'dart:convert';
import 'package:familly_finance/FrontScreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String pemasukan = '';
String pengeluaran = '';
String pemasukanUser = '';
String pengeluaranUser = '';

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  List _getPemasukan = [];
  List _getPengeluaran = [];
  List _getPemasukanUser = [];
  List _getPengeluaranUser = [];

  //make different color to different card

  @override
  void initState() {
    super.initState();
    //in first time, this method will be executed
    _getTotalPemasukan();
    _getTotalPengeluaran();
    _getUserTotalPemasukan();
    _getUserTotalPengeluaran();
  }

  Future _getTotalPemasukan() async {
    try {
      final response = await http.get(
        Uri.parse(
            //you have to take the ip address of your computer.
            //because using localhost will cause an error
            "http://192.168.1.8/familly_finance/php/TotalPemasukan.php"),
      );
      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // entry data to variabel list _get
        setState(() {
          _getPemasukan = data;
          pemasukan = _getPemasukan[0]['totalpemasukan'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _getUserTotalPemasukan() async {
    try {
      final response = await http.get(
        Uri.parse(
            //you have to take the ip address of your computer.
            //because using localhost will cause an error
            "http://192.168.1.8/familly_finance/php/detailTotalPemasukan.php?id_user=$id_user"),
      );
      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // entry data to variabel list _get
        setState(() {
          _getPemasukanUser = data;
          pemasukanUser = _getPemasukanUser[0]['totalPemasukanUser'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _getTotalPengeluaran() async {
    try {
      final response = await http.get(
        Uri.parse(
            //you have to take the ip address of your computer.
            //because using localhost will cause an error
            "http://192.168.1.8/familly_finance/php/TotalPengeluaran.php"),
      );
      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // entry data to variabel list _get
        setState(() {
          _getPengeluaran = data;
          pengeluaran = _getPengeluaran[0]['totalpengeluaran'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _getUserTotalPengeluaran() async {
    try {
      final response = await http.get(
        Uri.parse(
            //you have to take the ip address of your computer.
            //because using localhost will cause an error
            "http://192.168.1.8/familly_finance/php/detailTotalPengeluaran.php?id_user=$id_user"),
      );
      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // entry data to variabel list _get
        setState(() {
          _getPengeluaranUser = data;
          pengeluaranUser = _getPengeluaranUser[0]['totalPengeluaranUser'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.repeated,
                colors: [
                  Colors.white,
                  Colors.grey,
                ]),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$username Money :",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Pemasukan ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _getPemasukanUser.length == 0
                      ? 'Rp. 0'
                      : "Rp. ${pemasukanUser.toString()}",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Pengeluaran  ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _getPengeluaranUser.length == 0
                      ? 'Rp. 0'
                      : "Rp. ${pengeluaranUser.toString()}",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Familly Money :",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Pemasukan ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _getPemasukan.length == 0
                      ? 'Rp. 0'
                      : "Rp. ${pemasukan.toString()}",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Pengeluaran  ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _getPengeluaran.length == 0
                      ? 'Rp. 0'
                      : "Rp. ${pengeluaran.toString()}",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
