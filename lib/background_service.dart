import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class ExpiryNotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  ExpiryNotificationService() {
    tz.initializeTimeZones();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings androidInitialization =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitialization);

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> checkExpiryDates() async {
    DateTime now = DateTime.now();
    DateTime alertThreshold = now.add(Duration(days: 2)); // Notify 2 days before expiry

    QuerySnapshot productsSnapshot =
    await _firestore.collection('Products').get();

    for (var doc in productsSnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      DateTime expiryDate = (data['expiryDate'] as Timestamp).toDate();

      if (expiryDate.isBefore(alertThreshold)) {
        _sendNotification(data['productName'], expiryDate);
      }
    }
  }

  Future<void> _sendNotification(String productName, DateTime expiryDate) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'expiry_channel', 'Expiry Notifications',
        importance: Importance.high,
        priority: Priority.high);

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      "Product Expiry Alert",
      "$productName is expiring on ${expiryDate.toLocal().toString().split(' ')[0]}",
      notificationDetails,
    );
  }
}
