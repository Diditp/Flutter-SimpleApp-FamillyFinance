import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

enum LoginStatus { notSignIn, signIn }

class _AddState extends State<Add> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  final _formKey = GlobalKey<FormState>();
  bool _isHidePassword = true;

  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  check() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http.post(
        Uri.parse("http://192.168.18.27/familly_finance/php/tes.php"),
        body: {"username": user.text, "pass": pass.text});

    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String userAPI = data['username'].toString();
    String passAPI = data['pass'].toString();
    String id = data['id_user'].toString();
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, userAPI, passAPI, id);
      });
      print(pesan);
    } else {
      print(pesan);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login Gagal'),
      ));
    }
  }

  savePref(int value, String user, String pass, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("pass", pass);
      preferences.setString("username", user);
      preferences.setString("id_user", id);
      // ignore: deprecated_member_use
      preferences.commit();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      // ignore: deprecated_member_use
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  //inisialize field
  TextEditingController user = TextEditingController();

  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 12, 12, 111),
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
                      height: 30,
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
                                fillColor:
                                    const Color.fromARGB(255, 12, 12, 111),
                                filled: true,
                                prefixIcon: const Icon(Icons.person,
                                    color: Colors.white),
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                              validator: (e) {
                                if (e!.isEmpty) {
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
                                  fillColor:
                                      const Color.fromARGB(255, 12, 12, 111),
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                              validator: (e) {
                                if (e!.isEmpty) {
                                  return 'Tidak Bolek Kosong!';
                                }
                                return null;
                              },
                            ),
                            Padding(
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
                                    check();
                                  },
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
      case LoginStatus.signIn:
        return MainMenu(signOut);
    }
  }
}

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;
  MainMenu(this.signOut);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String user = "", pass = "";
  late TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user = preferences.getString("username")!;
      pass = preferences.getString("pass")!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Halaman Dashboard"),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  signOut();
                },
                icon: Icon(Icons.lock_open),
              )
            ],
          ),
          body: Center(
            child: Text("Dashboard"),
          )),
    );
  }
}
