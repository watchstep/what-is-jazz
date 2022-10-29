import 'package:flutter/material.dart';
import 'package:what_is_jazz/routes.dart';
import 'package:what_is_jazz/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What is Jazz?',
      theme: ThemeData(
          fontFamily: 'SpoqaHanSans',
          backgroundColor: Colors.black87,
          scaffoldBackgroundColor: Colors.black87
          // 0xff + Hex
          ),
      home: SplashScreen(),
      routes: routes,
    );
  }
}
