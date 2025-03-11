// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   Future<void> initNotifications() async {
//     var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings = InitializationSettings(android: androidSettings);
//     await _notificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future<void> scheduleExpiryNotifications() async {
//     var products = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection('products')
//         .get();
//
//     for (var product in products.docs) {
//       DateTime expiryDate = DateTime.parse(product['expiry_date']);
//       DateTime today = DateTime.now();
//       int daysLeft = expiryDate.difference(today).inDays;
//
//       if (daysLeft <= 5 && daysLeft >= 0) {
//         _showNotification(product['name'], daysLeft);
//       }
//     }
//   }
//
//   Future<void> _showNotification(String productName, int daysLeft) async {
//     var androidDetails = AndroidNotificationDetails(
//       "expiry_channel",
//       "Expiry Notifications",
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//     var notificationDetails = NotificationDetails(android: androidDetails);
//
//     await _notificationsPlugin.show(
//       0,
//       "Expiry Alert!",
//       "$productName is expiring in $daysLeft days!",
//       notificationDetails,
//     );
//   }
// }







//notim
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // ✅ Initialize the notification service
  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();
  }

  // ✅ Request notification permission
  static Future<void> requestPermission() async {
    final bool? granted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    if (granted == null || !granted) {
      print('Notification permission denied!');
    } else {
      print('Notification permission granted!');
    }
  }

  // ✅ Schedule expiry notification
  static Future<void> scheduleNotification(String productName, DateTime expiryDate) async {
    // Notify 1 day before expiry
    DateTime notifyTime = expiryDate.subtract(const Duration(days: 3));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Expiry Reminder',
      'The product "$productName" is expiring soon! Use it before ${expiryDate.toLocal().toString().split(' ')[0]}.',
      tz.TZDateTime.from(notifyTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'Expiry Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,  // ✅ FIXED!
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
