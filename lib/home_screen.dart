//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'login_screen.dart';  // Import LoginScreen
// import 'sign_up_screen.dart';  // Import SignUpScreen (assuming you have this file)
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   Future<void> _signOut(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Screen'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.exit_to_app),
//             onPressed: () => _signOut(context), // Sign out button
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Welcome to Smart Tracker!',
//               style: TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 20),  // Space between text and buttons
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to LoginScreen when the Login button is pressed
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginScreen()),
//                 );
//               },
//               child: const Text('Login'),
//             ),
//             const SizedBox(height: 20),  // Space between buttons
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to SignUpScreen when the Signup button is pressed
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SignUpScreen()),  // Assuming SignUpScreen exists
//                 );
//               },
//               child: const Text('Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



//noti
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'login_screen.dart';  // Import LoginScreen
// import 'sign_up_screen.dart';  // Import SignUpScreen
//
// // Initialize Flutter Local Notifications Plugin
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _initializeNotifications();
//   }
//
//   // Initialize Notifications
//   Future<void> _initializeNotifications() async {
//     const AndroidInitializationSettings androidSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const InitializationSettings initializationSettings =
//     InitializationSettings(android: androidSettings);
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   // Function to show a test notification
//   Future<void> _showNotification() async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'channelId', 'channelName',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const NotificationDetails notificationDetails =
//     NotificationDetails(android: androidDetails);
//
//     await flutterLocalNotificationsPlugin.show(
//         0, 'Test Notification', 'This is a test message.', notificationDetails);
//   }
//
//   // Function to sign out
//   Future<void> _signOut(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Screen'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.exit_to_app),
//             onPressed: () => _signOut(context), // Sign out button
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Welcome to Smart Tracker!',
//               style: TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 20), // Space between text and buttons
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginScreen()),
//                 );
//               },
//               child: const Text('Login'),
//             ),
//             const SizedBox(height: 20), // Space between buttons
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SignUpScreen()),
//                 );
//               },
//               child: const Text('Sign Up'),
//             ),
//             const SizedBox(height: 20), // Space for better layout
//             ElevatedButton(
//               onPressed: _showNotification, // Trigger notification
//               child: const Text('Show Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







//notim
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';
import 'notification_service.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Function to sign out the user
  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  // Function to parse different date formats
  DateTime parseDate(String dateString) {
    List<String> formats = ['dd/MM/yyyy', 'dd-MM-yyyy', 'yyyy-MM-dd'];
    for (String format in formats) {
      try {
        return DateFormat(format).parse(dateString);
      } catch (e) {
        continue;
      }
    }
    throw Exception('Invalid date format: $dateString');
  }

  // Function to request permission & schedule notifications
  Future<void> _requestAndScheduleNotification() async {
    await NotificationService.requestPermission();

    // Example list of products with expiry dates in different formats
    List<Map<String, dynamic>> products = [
      {'name': 'Milk', 'expiry': '15/03/2025'},
      {'name': 'Cheese', 'expiry': '2025-03-20'},
      {'name': 'Yogurt', 'expiry': '17-03-2025'},
    ];

    for (var product in products) {
      try {
        DateTime expiryDate = parseDate(product['expiry']);
        await NotificationService.scheduleNotification(product['name'], expiryDate);
      } catch (e) {
        print('Error parsing date for ${product['name']}: $e');
      }
    }
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
            const SizedBox(height: 20), // Space between text and buttons
            ElevatedButton(
              onPressed: () {
                // Request permissions and schedule expiry notifications
                _requestAndScheduleNotification();
              },
              child: const Text('Enable Expiry Notifications'),
            ),
            const SizedBox(height: 20), // Space between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to LoginScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20), // Space between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to SignUpScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
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
