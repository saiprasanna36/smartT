import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Change to your main screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to home screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Change this to your main screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Images/splash_logo.jpg', height: 150), // Your logo
            SizedBox(height: 20),
            CircularProgressIndicator(), // Loading animation
          ],
        ),
      ),
    );
  }
}
