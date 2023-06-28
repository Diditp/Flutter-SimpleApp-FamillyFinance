import 'package:familly_finance/FrontScreen/LoginScreen.dart';
import 'package:familly_finance/FrontScreen/SignUpScreen.dart';
import 'package:familly_finance/FrontScreen/SplashScreen.dart';
import 'package:familly_finance/adminScreen/HomeAdminScreen.dart';
import 'package:familly_finance/adminScreen/CRUDscreenAdmin/AdminInputMoneyScreen.dart';
import 'package:familly_finance/adminScreen/CRUDscreenAdmin/AdminRecentActivityScreen.dart';
import 'package:familly_finance/adminScreen/CRUDscreenAdmin/AdminUpdateMoneyScreen.dart';
import 'package:familly_finance/adminScreen/CRUDscreenAdmin/UpdateUserScreen.dart';
import 'package:familly_finance/adminScreen/CRUDscreenAdmin/UserDataScreen.dart';
import 'package:familly_finance/memberScreen/CRUDscreenMember/MemberDataTable.dart';
import 'package:familly_finance/memberScreen/CRUDscreenMember/MemberInputMoneyScreen.dart';
import 'package:familly_finance/memberScreen/CRUDscreenMember/MemberRecentActivityScreen.dart';
import 'package:familly_finance/memberScreen/CRUDscreenMember/MemberUpdateMoneyScreen.dart';
import 'package:familly_finance/memberScreen/CRUDscreenMember/MemberUserAcount.dart';
import 'package:familly_finance/memberScreen/HomeMemberScreen.dart';
import 'package:familly_finance/models/AboutScreen.dart';
import 'package:familly_finance/adminScreen/CRUDscreenAdmin/AdminDataTable.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

String username = '';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Bitter',
      ),
      debugShowCheckedModeBanner: false,
      title: 'Familly Finance',
      home: const SplashScreen(),
      routes: <String, WidgetBuilder>{
        //AdminScreen
        '/HomeAdminScreen': (BuildContext context) => HomeAdminScreen(
              username: username,
            ),
        '/AdminRecentActivityScreen': (BuildContext context) =>
            const AdminRecentActivityScreen(),
        '/UserDataScreen': (BuildContext context) => const UserDataScreen(),
        '/AdminInputMoneyScreen': (BuildContext context) =>
            const AdminInputMoneyScreen(),
        '/UpdateUserScreen': (BuildContext context) => UpdateUserScreen(
              id: '',
            ),
        '/AdminUpdateScreen': (BuildContext context) =>
            AdminUpdateScreen(id: ''),
        '/AdminTableScreen': (BuildContext context) =>
            const AdminDataTableView(),
        '/AboutScreen': (BuildContext context) => const AboutScreen(),

        //MemberScreen
        '/MemberInputMoneyScreen': (BuildContext context) =>
            const MemberInputMoneyScreen(),
        '/HomeMemberScreen': (BuildContext context) => HomeMemberScreen(
              username: username,
            ),
        '/MemberUpdateScreen': (BuildContext context) =>
            MemberUpdateScreen(id: ''),
        '/MemberRecentActivityScreen': (BuildContext context) =>
            const MemberRecentActivityScreen(),
        '/UserAcountScreen': (BuildContext context) => UserAcountScreen(),
        // '/MemberTableScreen': (BuildContext context) => const MemberTableView(),

        //FrontScreen
        '/LoginScreen': (BuildContext context) => const LoginScreen(),
        '/SplashScreen': (BuildContext context) => const SplashScreen(),
        '/SignUpScreen': (BuildContext context) => const SignUpScreen(),
      },
    );
  }
}
