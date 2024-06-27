import 'dart:convert';
import 'package:digister/main.dart';
import 'package:digister/screens/confirmation/confirmation_screen.dart';
import 'package:digister/screens/loading/loading_screen.dart';
import 'package:digister/services/auth.dart';
import 'package:digister/services/dues.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:page_transition/page_transition.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseMessaging get firebaseMessaging => _firebaseMessaging;

  final _androidChannel = const AndroidNotificationChannel(
    "importance_channel",
    "Importance Notifications",
    description: "This is for importance notifications",
    importance: Importance.high,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;

    final data = message.data;

    if (data['tipe'] == 'Input') {
      navigatorKey.currentState!.push(
        PageTransition(
          child: const ConfirmationScreen(fromNotification: true),
          type: PageTransitionType.rightToLeft,
        ),
      );
      return;
    }

    final dues = await getDuesById(data['id']);

    if (dues != null) {
      navigatorKey.currentState!.push(
        PageTransition(
          child: LoadingScreen(
            dues: dues,
            isInfo: true,
            fromNotification: true,
          ),
          type: PageTransitionType.rightToLeft,
        ),
      );
    }
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
        handleMessage(message);
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      final android = message.notification?.android;
      if (notification == null) return;

      if (android != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: "@drawable/ic_launcher",
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });

    // subscribe to topic so server can make a broadcast
    await _firebaseMessaging.subscribeToTopic('payment');
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.deleteToken();
    final fCMToken = await _firebaseMessaging.getToken();
    initPushNotifications();
    initLocalNotifications();

    // save token to database
    await saveToken(fCMToken!);

    // Any time the token refreshes, store this in the database too.
    _firebaseMessaging.onTokenRefresh.listen(saveToken);
  }
}
