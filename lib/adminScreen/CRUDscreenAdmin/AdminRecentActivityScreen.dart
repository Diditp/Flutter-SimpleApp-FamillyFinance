// ignore_for_file: file_names

import 'dart:convert';
import 'package:familly_finance/adminScreen/CRUDscreenAdmin/AdminUpdateMoneyScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminRecentActivityScreen extends StatefulWidget {
  const AdminRecentActivityScreen({super.key});

  @override
  State<AdminRecentActivityScreen> createState() =>
      _AdminRecentActivityScreenState();
}

class _AdminRecentActivityScreenState extends State<AdminRecentActivityScreen> {
  List _get = [];

  //make different color to different card

  @override
  void initState() {
    super.initState();
    //in first time, this method will be executed
    _getData();
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

  Future _onDelete(context) async {
    try {
      return await http
          .delete(
        Uri.parse("http://192.168.1.8/familly_finance/php/deleteAllTrans.php"),
      )
          .then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("All Data Already Deleted")));

        // Remove all existing routes until the home.dart, then rebuild Home.
        Navigator.pushReplacementNamed(context, '/AdminRecentActivityScreen');
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 111),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/HomeAdminScreen');
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        title: const Text(
          "Log Aktivitas",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Lobster',
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    //show dialog to confirm delete data
                    return AlertDialog(
                      content: const Text(
                          'Apakah Kamu Yakin Ingin Menghapus Semua ?'),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 12, 12, 111),
                          )),
                          child: const Icon(
                            Icons.cancel,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 12, 12, 111),
                          )),
                          child: const Icon(
                            Icons.check_circle,
                          ),
                          onPressed: () => _onDelete(context),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.white,
          height: 50.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/HomeAdminScreen');
                        },
                        icon: const Icon(
                          Icons.home,
                          color: Colors.black,
                          size: 20,
                          semanticLabel: 'tes',
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 12, 12, 111),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/AdminInputMoneyScreen');
                        },
                        icon: const Icon(
                          Icons.add_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/AdminRecentActivityScreen');
                        },
                        icon: const Icon(
                          Icons.monetization_on,
                          color: Colors.black,
                        ),
                        iconSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: _get.isNotEmpty
          ? ListView.builder(
              itemCount: _get.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            //routing into edit page
                            //we pass the id note
                            MaterialPageRoute(
                              builder: (context) => AdminUpdateScreen(
                                id: _get[index]['id_keuangan'],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 12, 12, 111),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${_get[index]['nama']}'.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 350,
                                    child: Divider(
                                      height: 15,
                                      color: Colors.black,
                                      thickness: 3,
                                    ),
                                  ),
                                  const Text(
                                    'Tanggal : ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        '[${_get[index]['tanggal']}]',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Keterangan : ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.description,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        '[${_get[index]['keterangan']}]',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Pengeluaran : ',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.upload,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        '[Rp. ${_get[index]['pengeluaran']}]',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Pemasukan : ',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.download,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        '[Rp. ${_get[index]['pemasukan']}]',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })
          : const Center(
              child: Text(
              'No Data Found',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/AdminTableScreen');
        },
        backgroundColor: Colors.grey.shade700,
        tooltip: 'Table Data',
        child: const Icon(
          Icons.table_chart_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
