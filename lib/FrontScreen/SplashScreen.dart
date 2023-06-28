// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 8);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, '/LoginScreen');
    });
  }

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 111),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/Logo.png',
              width: 250.0,
              height: 250.0,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          const Text(
            "Family Finance",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              fontFamily: 'Lobster',
            ),
          ),
        ],
      ),
    );
  }
}
