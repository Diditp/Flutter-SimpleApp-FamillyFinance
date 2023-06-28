import 'dart:convert';

import 'package:familly_finance/FrontScreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String pemasukan = '';
String pengeluaran = '';

class AdminDataTableView extends StatefulWidget {
  const AdminDataTableView({super.key});

  @override
  State<AdminDataTableView> createState() => _AdminDataTableViewState();
}

class _AdminDataTableViewState extends State<AdminDataTableView> {
  List _get = [];

  //make different color to different card

  List _getPemasukan = [];
  List _getPengeluaran = [];

  //make different color to different card

  @override
  void initState() {
    super.initState();
    //in first time, this method will be executed
    _getTotalPemasukan();
    _getTotalPengeluaran();
    _getData();
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

  Future _getData() async {
    try {
      final response = await http.get(
        Uri.parse(
            //you have to take the ip address of your computer.
            //because using localhost will cause an error
            "http://192.168.1.8/familly_finance/php/money_data_list.php"),
      );

      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // entry data to variabel list _get
        setState(() {
          _get = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  SingleChildScrollView _tableBarang() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(
                label: Text(
              "Nama",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
            DataColumn(
                label: Text(
              "Tanggal",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
            DataColumn(
                label: Text(
              "Keterangan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
            DataColumn(
                label: Text(
              "Pemasukan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
            DataColumn(
                label: Text(
              "Pengeluaran",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
          ],
          rows: _get
              .map(
                (item) => DataRow(
                  color:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  cells: <DataCell>[
                    DataCell(Text(item['nama'])),
                    DataCell(Text(item['tanggal'])),
                    DataCell(Text(item['keterangan'])),
                    DataCell(Text(item['pemasukan'])),
                    DataCell(Text(item['pengeluaran'])),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 111),
      appBar: AppBar(
        shadowColor: Colors.grey,
        title: Text(
          "Table History Keuangan",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Lobster',
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, '/AdminRecentActivityScreen');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      // backgroundColor: Color.fromARGB(255, 12, 12, 111),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(children: <Widget>[
          _tableBarang(),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Total Pemasukan ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Text(
                            _getPemasukan.length == 0
                                ? '     =  Rp. 0'
                                : "     =  Rp. ${pemasukan.toString()}",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Pengeluaran  ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          Text(
                            _getPengeluaran.length == 0
                                ? ' =  Rp. 0'
                                : " =  Rp. ${pengeluaran.toString()}",
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
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
