import 'dart:async';
import 'dart:convert';

import 'package:doc_talk/models/otp_verification.dart';
import 'package:doc_talk/shared_pref/shared_pref.dart';
import 'package:doc_talk/shared_pref/shared_pref_const.dart';
import 'package:flutter/material.dart';

import '../dasboard/dashboard_home.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    onSplashStart();
  }

  onSplashStart() async {
    var accesstoken = await PrefUtils.getString(ACCESS_TOKEN, '');
    var userDetail = await PrefUtils.getString(USER_DETAIL, '');

      if (accesstoken.toString() != '') {
        if (userDetail.toString() != '') {
          User userDetails = User.fromJson(jsonDecode(userDetail));
        }
        Navigator.of(context)
            .pushReplacementNamed(DashboardHomeScreen.route);
      } else {
        Navigator.of(context).pushReplacementNamed(AuthScreen.route);
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          height: 250,
          width: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/xyba_logo.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
