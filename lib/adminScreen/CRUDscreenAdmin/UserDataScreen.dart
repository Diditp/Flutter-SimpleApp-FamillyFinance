// ignore_for_file: file_names

import 'dart:convert';
import 'package:familly_finance/adminScreen/CRUDscreenAdmin/UpdateUserScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
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
            "http://192.168.1.8/familly_finance/php/user_list.php"),
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
          "User Data",
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
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        //routing into edit page
                        //we pass the id note
                        MaterialPageRoute(
                          builder: (context) => UpdateUserScreen(
                            id: _get[index]['id_user'],
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
                            child: Text(
                              '${_get[index]['username']}'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
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
                                'E-mail : ',
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
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    '[${_get[index]['email']}]',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Level Akses : ',
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
                                    Icons.accessibility_new,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    '[${_get[index]['levels']}]',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Password : ',
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
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    '[${_get[index]['pass']}]',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
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
                );
              })
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
