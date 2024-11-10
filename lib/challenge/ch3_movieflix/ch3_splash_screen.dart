import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toonflix/challenge/ch3_movieflix/screens/ch3_home_screen.dart';

class Ch3SplashScreen extends StatefulWidget {
  const Ch3SplashScreen({super.key});

  @override
  State<Ch3SplashScreen> createState() => _Ch3SplashScreenState();
}

class _Ch3SplashScreenState extends State<Ch3SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Ch3HomeScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "MOVIEFLIX 🍿",
          style: TextStyle(
            color: Colors.red,
            fontSize: 50,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
