// ignore_for_file: unused_field, unused_local_variable, non_constant_identifier_names, avoid_print, unused_element

import 'dart:convert';

import 'package:e_valve/controllers/notification_controller.dart';
import 'package:e_valve/pages/notification_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // print('Title: ${message.notification?.title}');
  // print('Body: ${message.notification?.body}');
  // print('Payload: ${message.data}');
}

class FireBaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final notifController = Get.put(NotificationController());

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for important notification',
      importance: Importance.defaultImportance);

  final _localNotifications = FlutterLocalNotificationsPlugin();

  //? initialing the notification methode
  Future<void> initNotifications() async {
    //requesting the permission to user
    await _firebaseMessaging.requestPermission();

    void handleMessage(RemoteMessage? message) {
      if (message == null) return;

      Get.to(NotificationPage());
      notifController.addNotification(message);
    }

    Future initLocationNotification() async {
      // const iOs = IOSInitializationSettings();
      const android = AndroidInitializationSettings('@drawable/timo');
      const settings = InitializationSettings(
        android: android,
      );

      await _localNotifications.initialize(
        settings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
          final payload = notificationResponse.payload;
          if (payload != null) {
            final message = RemoteMessage.fromMap(jsonDecode(payload));
            handleMessage(message);
          }
        },
      );

      final platform =
          _localNotifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      await platform?.createNotificationChannel(_androidChannel);
    }

    Future initPushNotifications() async {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
              alert: true, badge: true, sound: true);

      //Performing action when app is open from the terminated state via notification
      FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

      //performing action when app is open from the bacground state via notification
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

      //Receiving message from the bacground and terminated state
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

      //Trigger whenever the message arrive the app is in the foreground
      FirebaseMessaging.onMessage.listen((message) {
        final notification = message.notification;
        if (notification == null) return;

        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/timo')),
          payload: jsonEncode(message.toMap()),
        );
      });
    }

    //Geting the token from the user device
    final FCMToken = await _firebaseMessaging.getToken();
    print('Here is the token: $FCMToken');

    initPushNotifications();
    initLocationNotification();
  }
}
