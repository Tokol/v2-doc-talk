import 'package:doc_talk/ui/auth/auth_screen.dart';
import 'package:doc_talk/ui/dasboard/dashboard.dart';
import 'package:doc_talk/ui/auth/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doc Talk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF5A227E),
      ),
      //home: const SplashScreen(),
      routes: {
        '/': (BuildContext context) => const SplashScreen(),
        AuthScreen.route: (BuildContext context) => const AuthScreen(),
        DashBoardScreen.route:(BuildContext context) => DashBoardScreen(),
      },
    );
  }
}
