import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';  // Import LoginScreen
import 'sign_up_screen.dart';  // Import SignUpScreen (assuming you have this file)

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _signOut(context), // Sign out button
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Smart Tracker!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),  // Space between text and buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to LoginScreen when the Login button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),  // Space between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to SignUpScreen when the Signup button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),  // Assuming SignUpScreen exists
                );
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
