// ignore_for_file: file_names

import 'dart:convert';
import 'package:familly_finance/FrontScreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

String pengeluaran = '';
String pemasukan = '';

class MemberInputMoneyScreen extends StatefulWidget {
  const MemberInputMoneyScreen({super.key});

  @override
  State<MemberInputMoneyScreen> createState() => _MemberInputMoneyScreenState();
}

class _MemberInputMoneyScreenState extends State<MemberInputMoneyScreen> {
  TextEditingController nama = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController pemasukan = TextEditingController();
  TextEditingController pengeluaran = TextEditingController();

  Future _onSubmit() async {
    try {
      return await http.post(
        Uri.parse("http://192.168.1.8/familly_finance/php/input_money.php"),
        body: {
          'id_user': id_user,
          "nama": nama.text,
          "tanggal": tanggal.text,
          "keterangan": keterangan.text,
          "pemasukan": pemasukan.text,
          "pengeluaran": pengeluaran.text,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data Added Succesfully")));

        Navigator.pushReplacementNamed(context, '/MemberRecentActivityScreen');
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/HomeMemberScreen');
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        title: const Text(
          "Input Uang",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Lobster',
          ),
        ),
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
                              context, '/HomeMemberScreen');
                        },
                        icon: const Icon(
                          Icons.home,
                          color: Colors.black,
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
                        color: const Color.fromARGB(255, 12, 12, 111),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/MemberInputMoneyScreen');
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
                              context, '/MemberRecentActivityScreen');
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
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Family Finance",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    fontFamily: 'Lobster',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 12, 12, 111),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      child: TextField(
                        scrollPadding: const EdgeInsets.only(bottom: 40),
                        style: const TextStyle(color: Colors.white),
                        controller: nama,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 12, 12, 111),
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.white),
                          labelText: 'Nama',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          hintText: 'Your Name',
                          hintStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      child: TextField(
                        scrollPadding: const EdgeInsets.only(bottom: 40),
                        style: const TextStyle(color: Colors.white),
                        controller: tanggal,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 12, 12, 111),
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.date_range, color: Colors.white),
                          labelText: 'Tanggal',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          hintText: 'yy/mm/dd',
                          hintStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              tanggal.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      child: TextField(
                        scrollPadding: const EdgeInsets.only(bottom: 40),
                        style: const TextStyle(color: Colors.white),
                        controller: keterangan,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 12, 12, 111),
                          filled: true,
                          prefixIcon: const Icon(Icons.description,
                              color: Colors.white),
                          labelText: 'Keterangan',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          hintText: 'Ketarangan',
                          hintStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      child: TextField(
                        scrollPadding: const EdgeInsets.only(bottom: 40),
                        style: const TextStyle(color: Colors.white),
                        controller: pengeluaran,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 12, 12, 111),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.money,
                            color: Colors.white,
                          ),
                          labelText: 'Pengeluaran',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          hintText: 'Nominal',
                          hintStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      child: TextField(
                        scrollPadding: const EdgeInsets.only(bottom: 40),
                        style: const TextStyle(color: Colors.white),
                        controller: pemasukan,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 12, 12, 111),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.money,
                            color: Colors.white,
                          ),
                          labelText: 'Pemasukan',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          hintText: 'Nominal',
                          hintStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        height: 47,
                        width: 313,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: TextButton(
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _onSubmit();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
