// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'add_product_screen.dart';
// import 'view_products_screen.dart';
// import 'login_screen.dart';
//
// class DashboardScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // 🔹 Handle user logout
//   Future<void> _signOut(BuildContext context) async {
//     await _auth.signOut();
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//           (route) => false, // Removes all previous routes
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () => _signOut(context), // Call the logout function
//           ),
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.add),
//                 label: const Text('Add Product'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 50), // Full width button
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const AddProductScreen()),
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.view_list),
//                 label: const Text('View Products'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 50),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const ViewProducts()),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





//noti
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'add_product_screen.dart';
// import 'view_products_screen.dart';
// import 'login_screen.dart';
// import 'notification_service.dart'; // Import notification service
//
// class DashboardScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // 🔹 Handle user logout
//   Future<void> _signOut(BuildContext context) async {
//     await _auth.signOut();
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//           (route) => false, // Removes all previous routes
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () => _signOut(context), // Call the logout function
//           ),
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // ✅ Add Product Button
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.add),
//                 label: const Text('Add Product'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 50), // Full width button
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const AddProductScreen()),
//                   );
//                 },
//               ),
//
//               const SizedBox(height: 20),
//
//               // ✅ View Products Button
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.view_list),
//                 label: const Text('View Products'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 50),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const ViewProducts()),
//                   );
//                 },
//               ),
//
//               const SizedBox(height: 20),
//
//               // ✅ Show Notification Button
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.notifications),
//                 label: const Text('Show Notification'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 50),
//                 ),
//                 onPressed: () async {
//                   await NotificationService.showDashboardNotification();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




//UI
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'add_product_screen.dart';
// import 'view_products_screen.dart';
// import 'login_screen.dart';
// import 'notification_service.dart'; // Import notification service
//
// class DashboardScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // 🔹 Handle user logout
//   Future<void> _signOut(BuildContext context) async {
//     await _auth.signOut();
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//           (route) => false, // Removes all previous routes
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () => _signOut(context),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 15,
//           mainAxisSpacing: 15,
//           children: [
//             // ✅ Add Product Card
//             _buildDashboardCard(
//               icon: Icons.add_box,
//               title: "Add Product",
//               color: Colors.green,
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const AddProductScreen()),
//                 );
//               },
//             ),
//
//             // ✅ View Products Card
//             _buildDashboardCard(
//               icon: Icons.view_list,
//               title: "View Products",
//               color: Colors.orange,
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ViewProducts()),
//                 );
//               },
//             ),
//
//             // ✅ Show Notification Card
//             _buildDashboardCard(
//               icon: Icons.notifications_active,
//               title: "Show Notification",
//               color: Colors.blue,
//               onTap: () async {
//                 // await NotificationService.showDashboardNotification();
//               },
//             ),
//
//             // ✅ Logout Card
//             _buildDashboardCard(
//               icon: Icons.logout,
//               title: "Logout",
//               color: Colors.red,
//               onTap: () => _signOut(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // 🔹 Reusable Card Widget for Dashboard
//   Widget _buildDashboardCard({
//     required IconData icon,
//     required String title,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, size: 40, color: color),
//               const SizedBox(height: 10),
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



//d1
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_product_screen.dart';
import 'view_products_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Sign out function
  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    );
  }

  // 🔹 Show confirmation dialog before logout
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close dialog
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close dialog
              _signOut(context);       // Proceed to logout
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _showLogoutConfirmationDialog(context),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              _buildDashboardCard(
                icon: Icons.add_box,
                title: "Add Product",
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddProductScreen()),
                  );
                },
              ),
              _buildDashboardCard(
                icon: Icons.view_list,
                title: "View Products",
                color: Colors.orange,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewProducts()),
                  );
                },
              ),
              _buildDashboardCard(
                icon: Icons.logout,
                title: "Logout",
                color: Colors.red,
                onTap: () => _showLogoutConfirmationDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Dashboard Card Builder
  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
