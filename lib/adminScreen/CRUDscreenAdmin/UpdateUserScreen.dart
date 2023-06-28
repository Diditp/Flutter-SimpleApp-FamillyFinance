// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

String pengeluaran = '';
String pemasukan = '';

// ignore: must_be_immutable
class UpdateUserScreen extends StatefulWidget {
  UpdateUserScreen({super.key, required this.id});
  String id;

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  bool _isHidePassword = true;

  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController level = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void initState() {
    super.initState();
    //in first time, this method will be executed
    _getData();
  }

  //Http to get detail data
  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
          //you have to take the ip address of your computer.
          //because using localhost will cause an error
          //get detail data with id
          "http://192.168.1.8/familly_finance/php/detailUser.php?id_user='${widget.id}'"));

      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          username = TextEditingController(text: data['username']);
          email = TextEditingController(text: data['email']);
          level = TextEditingController(text: data['levels']);
          pass = TextEditingController(text: data['pass']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onUpdate(context) async {
    try {
      return await http.post(
        Uri.parse(
            "http://192.168.1.8/familly_finance/php/updateUser.php?id_user='${widget.id}'"),
        body: {
          "id_user": widget.id,
          "username": username.text,
          "email": email.text,
          "levels": level.text,
          "pass": pass.text,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data Update Succesfully")));

        Navigator.pushReplacementNamed(context, '/UserDataScreen');
      });
    } catch (e) {
      print(e);
    }
  }

  Future _onDelete(context) async {
    try {
      return await http.delete(
        Uri.parse(
            "http://192.168.1.8/familly_finance/php/deleteUser.php?id_user='${widget.id}'"),
        body: {
          "id_user": widget.id,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data Has Been Deleted")));

        // Remove all existing routes until the home.dart, then rebuild Home.
        Navigator.pushReplacementNamed(context, '/UserDataScreen');
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
            Navigator.pushReplacementNamed(context, '/UserDataScreen');
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        title: const Text(
          "Edit User Data",
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
                              context, '/HomeAdminScreen');
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
                        controller: username,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 12, 12, 111),
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.white),
                          labelText: 'Username',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          hintText: 'Your Username',
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
                        controller: email,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 12, 12, 111),
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.date_range, color: Colors.white),
                          labelText: 'Your Email',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          hintText: 'Email',
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
                        controller: level,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 12, 12, 111),
                          filled: true,
                          prefixIcon: const Icon(Icons.accessibility_new,
                              color: Colors.white),
                          labelText: 'Level',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          hintText: 'Level',
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
                        obscureText: _isHidePassword,
                        scrollPadding: const EdgeInsets.only(bottom: 40),
                        style: const TextStyle(color: Colors.white),
                        controller: pass,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _togglePassword();
                            },
                            child: Icon(
                              _isHidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color:
                                  _isHidePassword ? Colors.grey : Colors.blue,
                            ),
                          ),
                          isDense: true,
                          fillColor: const Color.fromARGB(255, 12, 12, 111),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.money,
                            color: Colors.white,
                          ),
                          labelText: 'Password User',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          hintText: 'Password User',
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
                            _onUpdate(context);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                            "Delete Data",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                //show dialog to confirm delete data
                                return AlertDialog(
                                  content: const Text(
                                      'Apakah Kamu Yakin Ingin Menghapus?'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                        (states) => const Color.fromARGB(
                                            255, 12, 12, 111),
                                      )),
                                      child: const Icon(
                                        Icons.cancel,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                        (states) => const Color.fromARGB(
                                            255, 12, 12, 111),
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
