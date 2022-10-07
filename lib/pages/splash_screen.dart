import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:what_is_jazz/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
      duration: 2500,
      splashIconSize: 350,
      backgroundColor: Colors.black,
      splashTransition: SplashTransition.fadeTransition,
      splash: Column(
        children: [
          SizedBox(
            child: Lottie.asset('assets/images/pause_play_white.json'),
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          Text('재즈가 뭐라고\n생각하세요?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 3,))
        ],
      ),
      nextScreen: const HomePage(),
    ));
  }
}
