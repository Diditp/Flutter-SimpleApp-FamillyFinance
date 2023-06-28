import 'package:familly_finance/FrontScreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserAcountScreen extends StatefulWidget {
  UserAcountScreen({super.key});

  @override
  State<UserAcountScreen> createState() => _UserAcountScreenState();
}

class _UserAcountScreenState extends State<UserAcountScreen> {
  bool _isHidePassword = true;

  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  TextEditingController pass = TextEditingController();
  TextEditingController pass_baru = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController level = TextEditingController();

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
          "http://192.168.1.8/familly_finance/php/detailUser.php?id_user=$id_user"));

      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          user = TextEditingController(text: data['username']);
          email = TextEditingController(text: data['email']);
          pass = TextEditingController(text: data['pass']);
          level = TextEditingController(text: data['levels']);
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
            "http://192.168.1.8/familly_finance/php/updateUser.php?id_user=$id_user"),
        body: {
          "id_user": id_user,
          "username": user.text,
          "email": email.text,
          "pass": pass_baru.text,
          "levels": level.text,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data Update Succesfully")));

        Navigator.pushReplacementNamed(context, '/HomeMemberScreen');
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
          "Your Account",
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
                        controller: user,
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
                        controller: email,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 12, 12, 111),
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.white),
                          labelText: 'Email',
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
                        readOnly: true,
                        scrollPadding: const EdgeInsets.only(bottom: 40),
                        style: const TextStyle(color: Colors.white),
                        controller: level,
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 12, 12, 111),
                          filled: false,
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
                        readOnly: true,
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
                          filled: false,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          hintText: 'Password',
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
                        controller: pass_baru,
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
                            Icons.lock,
                            color: Colors.white,
                          ),
                          labelText: 'Password Baru',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          hintText: 'Password Baru',
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
