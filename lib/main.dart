
//1
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:workmanager/workmanager.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'home_screen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'notification_service.dart';  // Import Notification Service
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   // Initialize Notifications
//   tz.initializeTimeZones();
//   await NotificationService().initNotifications();
//
//   // Initialize Workmanager for background task
//   Workmanager().initialize(
//     callbackDispatcher,
//     isInDebugMode: false,
//   );
//
//   // Register daily background task
//   Workmanager().registerPeriodicTask(
//     "check_expiry_task",
//     "check_expiry",
//     frequency: Duration(hours: 24),  // Runs once every 24 hours
//   );
//
//   runApp(const MyApp());
// }
//
// // Background task callback
// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     await NotificationService().checkForExpiringProducts();
//     return Future.value(true);
//   });
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Smart Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }








//2
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:workmanager/workmanager.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'home_screen.dart'; // Your home screen
// import 'splash_screen.dart'; // Custom splash screen
// import 'notification_service.dart'; // Import Notification Service
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Initialize Firebase
//   await Firebase.initializeApp();
//
//   // Request notification permission
//   await requestPermission();
//
//   // Initialize the NotificationService
//   tz.initializeTimeZones(); // Initialize Timezones for notifications
//   await NotificationService().initNotifications();
//
//   // Initialize Workmanager for background tasks
//   Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
//
//   // Register daily background task for checking product expiry
//   Workmanager().registerPeriodicTask(
//     "check_expiry_task",
//     "check_expiry",
//     frequency: Duration(hours: 24), // Runs once every 24 hours
//   );
//
//   runApp(const MyApp());
// }
//
// // // Background task callback
// // @pragma('vm:entry-point')
// // void callbackDispatcher() {
// //   Workmanager().executeTask((task, inputData) async {
// //     await NotificationService().checkForExpiringProducts();
// //     return Future.value(true);
// //   });
// // }
//
// // Future<void> requestPermission() async {
// //   final permissionStatus = await Permission.notification.request();
// //   if (permissionStatus != PermissionStatus.granted) {
// //     print('Notification permission denied');
// //   } else {
// //     print('Notification permission granted');
// //   }
// // }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Smart Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashScreen(), // Show splash screen first
//     );
//   }
// }






//exp

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'home_screen.dart';  // Import your home screen
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Initialize Firebase
//   // Request permission for notifications
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Smart Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomeScreen(),  // Set LoginScreen as the home screen initially
//     );
//   }
// }








//noti
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'home_screen.dart'; // Home screen file
//
// // Initialize the notification plugin
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   // Notification settings
//   var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
//   var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'SmartT App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }
//
// // Function to show a notification
// Future<void> showNotification() async {
//   var androidDetails = const AndroidNotificationDetails(
//     'channelId', 'channelName',
//     importance: Importance.max, priority: Priority.high,
//   );
//
//   var notificationDetails = NotificationDetails(android: androidDetails);
//
//   await flutterLocalNotificationsPlugin.show(
//       0, 'Test Notification', 'This is a test message.', notificationDetails);
// }
//




//notim
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'notification_service.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// void getToken() async {
//   String? token = await FirebaseMessaging.instance.getToken();
//   print("FCM Token: $token");
// }
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await NotificationService.init();
//   runApp(MyApp());
//   getToken();
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeScreen(),
//     );
//   }
// }
//
//
//




//notim1
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'home_screen.dart';
import 'notification_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handles notifications when app is in the background or terminated
  print("Background Message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.init();

  // Register background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());

  // Get FCM Token
  getToken();
}

void getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $token");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    setupFirebaseListeners();
  }

  // ✅ Request Notification Permissions
  void requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ Notifications Allowed");
    } else {
      print("❌ Notifications Denied");
    }
  }

  // ✅ Handle Notifications when App is Open (Foreground)
  void setupFirebaseListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground Notification: ${message.notification?.title}");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message.notification?.title ?? "No Title"),
          content: Text(message.notification?.body ?? "No Body"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Notifications")),
      body: Center(child: Text("Listening for Notifications...")),
    );
  }
}
