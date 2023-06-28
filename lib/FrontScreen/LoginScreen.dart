// ignore_for_file: file_names

import 'dart:convert';
import 'package:familly_finance/FrontScreen/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

String pengeluaran = '';
String pemasukan = '';
String username = '';
String id_user = '';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidePassword = true;
  List _get = [];

  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  TextEditingController user = TextEditingController();

  TextEditingController pass = TextEditingController();

  Future _login() async {
    final response = await http.post(
        Uri.parse("http://192.168.1.8/familly_finance/php/login.php"),
        body: {
          "username": user.text,
          "pass": pass.text,
        });
    if (response.statusCode == 200) {
      final datauser = jsonDecode(response.body);

      // entry data to variabel list _get
      setState(() {
        _get = datauser;
      });
    }

    if (_get.isEmpty) {
      setState(() {
        tampil();
      });
    } else {
      if (_get[0]['levels'] == 'admin') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Welcome To App")));
        Navigator.pushReplacementNamed(context, '/HomeAdminScreen');
      } else if (_get[0]['levels'] == 'member') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Welcome To App")));
        Navigator.pushReplacementNamed(context, '/HomeMemberScreen');
      }
      setState(() {
        id_user = _get[0]['id_user'];
        username = _get[0]['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 111),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 120,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/Logo.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Familly Finance",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lobster',
                  ),
                ),
                const SizedBox(
                  width: 250,
                  child: Divider(
                    height: 15,
                    color: Colors.white,
                    thickness: 3,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Please Log Into Your Existing Acount",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: user,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
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
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tidak Boleh Kosong!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: pass,
                          obscureText: _isHidePassword,
                          decoration: InputDecoration(
                              fillColor: const Color.fromARGB(255, 12, 12, 111),
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                              hintText: 'Your Password',
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
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _togglePassword();
                                },
                                child: Icon(
                                  _isHidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _isHidePassword
                                      ? Colors.grey
                                      : Colors.blue,
                                ),
                              ),
                              isDense: true),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tidak Bolek Kosong!';
                            }
                            return null;
                          },
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    //send data to database with this method
                                    _login();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void tampil() {
    Fluttertoast.showToast(
        msg: "LOGIN GAGAL",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
