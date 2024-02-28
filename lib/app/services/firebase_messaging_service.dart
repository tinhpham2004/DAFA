import 'dart:convert';

import 'package:dafa/app/core/values/app_consts.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FirebaseMessagingService {
  final firebaseMessaging = FirebaseMessaging.instance;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final signInController = Get.find<SignInController>();

  Future<void> HandleMessage(RemoteMessage? message) async {
    if (message == null) return;
    signInController.notifySenderId = message.data['senderId'];
    Get.toNamed(AppRoutes.message);
  }

  Future<void> HandleBackgroundMessage(RemoteMessage? message) async {
    if (message == null) return;
    signInController.notifySenderId = message.data['senderId'];
    Get.toNamed(AppRoutes.message);
  }

  Future<void> InitPushNotifications() async {
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    firebaseMessaging.getInitialMessage().then(HandleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(HandleMessage);
    FirebaseMessaging.onBackgroundMessage(HandleBackgroundMessage);
  }

  Future<void> InitNotifications() async {
    await firebaseMessaging.requestPermission();
    InitPushNotifications();
  }

  Future<String> GetToken() async {
    String token = '';
    await FirebaseMessaging.instance.getToken().then((value) {
      if (value != null) token = value;
    });
    return token;
  }

  Future<void> SendNotification(
      String title, String body, String senderId, String receiverToken) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${AppConsts.FCM_Key}',
        },
        body: jsonEncode(<String, dynamic>{
          "to": receiverToken,
          'priority': 'high',
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'data': <String, String>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'senderId': senderId,
          }
        }),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void InitLocalNotification() {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const initializationSettings =
        InitializationSettings(android: androidSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) {
      debugPrint(response.payload.toString());
    });
  }

  Future<void> ShowLocalNotification(RemoteMessage message) async {
    final styleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatTitle: true,
    );
    final androidDetails = AndroidNotificationDetails(
      'com.example.dafa',
      'mychannelid',
      importance: Importance.max,
      styleInformation: styleInformation,
      priority: Priority.max,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
    );
    await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, notificationDetails,
        payload: message.data['body']);
  }

  void FirebaseNotification() {
    InitLocalNotification();

    FirebaseMessaging.onMessageOpenedApp.listen(HandleMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await ShowLocalNotification(message);
    });
  }
}
