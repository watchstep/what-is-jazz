import 'package:flutter/material.dart';
import 'package:what_is_jazz/pages/home_page.dart';
import 'package:what_is_jazz/pages/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (context) => const HomePage(),
  '/splash': (context) => const SplashScreen(),
};
