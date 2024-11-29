import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.initializeFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  // Singleton pattern
  NotificationService._();
  static final NotificationService instance = NotificationService._();
  final _messaging = FirebaseMessaging.instance;

  // final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  bool _isInitialized = false;

  /// Initialize notification services
  Future<void> initialize() async {
    await _requestPermission();
    await _initializeFlutterLocalNotifications();
    await _setupMessageHandlers();
    // debugPrint('FCM Token: ${await _messaging.getToken()}');
  }

  /// Request notification permissions
  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('Permission status: ${settings.authorizationStatus}');
  }

  /// Set up message handlers for foreground, background, and terminated states
  Future<void> _setupMessageHandlers() async {
    // Handle notification when the app is launched from a terminated state
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) await _handleMessage(initialMessage);

    // Handle notification when the app is in foreground
    FirebaseMessaging.onMessage.listen((message) => showNotification(message));

    // Handle notification when the app is opened via notification
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // Handle background notifications
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Handle foreground and background messages
  Future<void> _handleMessage(RemoteMessage message) async {
    await showNotification(message);
  }

  /// Display a notification
  Future<void> showNotification(RemoteMessage message) async {
    final notification = message.notification;
    final androidDetails = message.notification?.android;

    if (notification != null && androidDetails != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  }

  /// Initialize local notifications
  Future<void> _initializeFlutterLocalNotifications() async {
    if (_isInitialized) return;

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotifications.initialize(initializationSettings);
    _isInitialized = true;
  }

  /// Public method for background handler to initialize local notifications
  Future<void> initializeFlutterNotifications() async {
    if (!_isInitialized) await _initializeFlutterLocalNotifications();
  }
}
