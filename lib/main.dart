import 'package:doc_talk/ui/auth/auth_screen.dart';
import 'package:doc_talk/ui/auth/splash_screen.dart';
import 'package:doc_talk/ui/dasboard/dashboard_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'helper/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doc Talk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF5A227E),
      ),
      //home: const SplashScreen(),
      navigatorKey: Utils.mainAppNav,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const SplashScreen(),
        AuthScreen.route: (BuildContext context) => const AuthScreen(),
        DashboardHomeScreen.route:(BuildContext context) => DashboardHomeScreen(),
      },
    );
  }
}
