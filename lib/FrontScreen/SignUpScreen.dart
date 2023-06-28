// ignore_for_file: file_names

import 'dart:convert';
import 'package:familly_finance/FrontScreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidePassword = true;
  String? level;

  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  TextEditingController user = TextEditingController();

  TextEditingController pass = TextEditingController();
  TextEditingController passConfirm = TextEditingController();
  TextEditingController email = TextEditingController();

  Future _onSubmit() async {
    try {
      return await http.post(
        Uri.parse("http://192.168.1.8/familly_finance/php/add_user.php"),
        body: {
          "username": user.text,
          "email": email.text,
          "pass": pass.text,
          "levels": level!,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Account Added")));

        Navigator.of(context)
            .pop(MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    } catch (e) {
      print(e);
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
                          controller: email,
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 12, 12, 111),
                            filled: true,
                            prefixIcon:
                                const Icon(Icons.email, color: Colors.white),
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                                color: Colors.white, fontSize: 15),
                            hintText: 'Your Email',
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
                              return 'Tidak Boleh Kosong!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: passConfirm,
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
                              hintText: 'Confirm Password',
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
                            if (value != pass.text) {
                              return 'Password Not Match!';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Level Accses : ",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              // Radio(
                              //     value: 'admin',
                              //     groupValue: level,
                              //     fillColor: MaterialStateColor.resolveWith(
                              //         (states) => Colors.white),
                              //     activeColor: Colors.blue,
                              //     onChanged: (String? value) {
                              //       setState(() {
                              //         level = value;
                              //       });
                              //     }),
                              // const Text(
                              //   "Admin",
                              //   style: TextStyle(fontSize: 15, color: Colors.white),
                              // ),
                              Radio(
                                value: 'member',
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white),
                                activeColor: Colors.blue,
                                groupValue: level,
                                onChanged: (String? value) {
                                  setState(() {
                                    level = value;
                                  });
                                },
                              ),
                              const Text(
                                "Member",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                                  if (_formKey.currentState!.validate()) {
                                    //send data to database with this method
                                    _onSubmit();
                                  }
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

  // void tampil() {
  //   Fluttertoast.showToast(
  //       msg: "LOGIN GAGAL",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }
}
