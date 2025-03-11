import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_product_screen.dart';
import 'view_products_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Handle user logout
  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false, // Removes all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context), // Call the logout function
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Product'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // Full width button
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddProductScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.view_list),
                label: const Text('View Products'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewProducts()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}