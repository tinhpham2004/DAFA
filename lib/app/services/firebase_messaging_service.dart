import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:dafa/app/core/values/app_consts.dart';
import 'package:dafa/app/models/match_user.dart';
import 'package:dafa/app/modules/chat/screens/call_screen.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/swipe/swipe_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class FirebaseMessagingService {
  final firebaseMessaging = FirebaseMessaging.instance;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final signInController = Get.find<SignInController>();
  final databaseService = DatabaseService();

  Future<String> GetToken() async {
    String token = '';
    await FirebaseMessaging.instance.getToken().then((value) {
      if (value != null) token = value;
    });
    return token;
  }

  void StartCountingTimer(RemoteMessage? message) {
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (Get.isRegistered<SwipeController>()) {
          ShowLocalCallNotification(message!);
          timer.cancel();
        }
      },
    );
  }

  Future<void> HandleMessage(RemoteMessage? message) async {
    if (message == null) return;
    if (message.data['category'] == 'message') {
      signInController.notifySenderId = message.data['senderId'];
      Get.toNamed(AppRoutes.message);
    } else {
      StartCountingTimer(message);
    }
  }

  Future<void> HandleBackgroundMessage(RemoteMessage? message) async {
    if (message == null) return;
    if (message.data['category'] == 'message') {
      signInController.notifySenderId = message.data['senderId'];
      Get.toNamed(AppRoutes.message);
    } else {
      StartCountingTimer(message);
    }
  }

  Future<void> InitPushNotifications() async {
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    firebaseMessaging.getInitialMessage().then(HandleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(HandleMessage);
    try {
      FirebaseMessaging.onBackgroundMessage(HandleBackgroundMessage);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> InitNotifications() async {
    await firebaseMessaging.requestPermission();
    InitPushNotifications();
    try {
      await suggestFriend();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> suggestFriend() async {
    final deviceToken = await GetToken();
    final matchUser = findBestMatch(
      signInController.userLikeList,
      signInController.matchList,
    );
    if (matchUser == null) return;
    signInController.suggestFriendList.add(matchUser);
    signInController.suggestFriendList.add(
      MatchUser(
        user: null,
        distance: 0,
      ),
    );
    await SendNotification(
      '🌟 Meet ${matchUser.user?.name}! Your Perfect Match Awaits! 🌟',
      'We think ${matchUser.user?.name} could be the one for you! They align perfectly with your interests and values. Tap to view their profile and start something amazing today! 💕',
      signInController.user.phoneNumber,
      deviceToken,
      matchUser: matchUser,
    );
  }

  Future<void> SendNotification(
      String title, String body, String senderId, String receiverToken,
      {MatchUser? matchUser}) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/${AppConsts.PROJECT_ID}/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await _getAccessToken()}',
        },
        body: jsonEncode(<String, dynamic>{
          'message': {
            'token': receiverToken,
            'notification': {
              'title': title,
              'body': body,
            },
            'data': matchUser != null
                ? matchUser.toJson()
                : {
                    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                    'status': 'done',
                    'senderId': senderId,
                    'category': 'message',
                  },
            'android': {
              'priority': 'high',
            },
          },
        }),
      );
      debugPrint(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> SendLocalCallNotification({
    required String title,
    required String body,
    required String receiverToken,
    required String callId,
    required String channel,
    required String caller,
    required String callee,
    required String token,
  }) async {
    try {
      await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/${AppConsts.PROJECT_ID}/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await _getAccessToken()}',
        },
        body: jsonEncode(<String, dynamic>{
          'message': {
            'token': receiverToken,
            'notification': {
              'title': title,
              'body': body,
            },
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'category':
                  channel.contains('videoCall') ? 'videoCall' : 'audioCall',
              'call_id': callId,
              'channel': channel,
              'caller': caller,
              'callee': callee,
              'token': token,
            },
            'android': {
              'priority': 'high',
            },
          },
        }),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> _getAccessToken() async {
    try {
      final serviceAccountJson =
          await rootBundle.loadString('assets/service_account.json');
      final credentials =
          ServiceAccountCredentials.fromJson(serviceAccountJson);

      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
      final client = await clientViaServiceAccount(credentials, scopes);

      final accessToken = await client.credentials.accessToken;
      client.close();

      return accessToken.data;
    } catch (e) {
      debugPrint('Error getting access token: $e');
      rethrow;
    }
  }

  void InitLocalNotification() {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const initializationSettings =
        InitializationSettings(android: androidSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) {
      if (response.payload != null) {
        try {
          final data = jsonDecode(response.payload!);
          final category = data['category'];
          final callId = data['call_id'];
          if (category != 'message' && category != null) {
            if (response.actionId == 'accept') {
              String channelName = data['channel'];
              String token = data['token'];
              signInController.notifySenderId = data['caller'];
              Get.to(CallScreen(
                channelName: channelName,
                token: token,
                callId: callId,
              ));
              databaseService.UpdateCallMessage(callId, 'accepted');
            } else if (response.actionId == 'reject') {
              databaseService.UpdateCallMessage(callId, 'rejected');
            }
          }
          if (category == null) {
            Get.toNamed(AppRoutes.suggest_friend);
          }
        } catch (ex) {
          print(ex.toString());
        }
      }
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
      if (message.data['category'] == 'message')
        await ShowLocalNotification(message);
      else
        await ShowLocalCallNotification(message);
    });
  }

  // Future<void> SendLocalCallNotification({
  //   required String title,
  //   required String body,
  //   required String receiverToken,
  //   required String callId,
  //   required String channel,
  //   required String caller,
  //   required String callee,
  //   required String token,
  // }) async {
  //   try {
  //     await http.post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Authorization': 'key=${AppConsts.FCM_Key}',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         "to": receiverToken,
  //         'priority': 'high',
  //         'notification': <String, dynamic>{
  //           'body': body,
  //           'title': title,
  //         },
  //         'data': <String, String>{
  //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //           'status': 'done',
  //           'category':
  //               channel.contains('videoCall') ? 'videoCall' : 'audioCall',
  //           'call_id': callId,
  //           'channel': channel,
  //           'caller': caller,
  //           'callee': callee,
  //           'token': token,
  //         }
  //       }),
  //     );
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  Future<void> ShowLocalCallNotification(RemoteMessage message) async {
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
      // actions: [
      //   AndroidNotificationAction('accept', 'Accept', showsUserInterface: true),
      //   AndroidNotificationAction('reject', 'Reject', showsUserInterface: true),
      // ],
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
    );
    await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, notificationDetails,
        payload: JsonToString(message.data));
  }

  String JsonToString(Map<String, dynamic> data) {
    String result = data.toString();
    Map<String, String> stringMap =
        data.map((key, value) => MapEntry(key.toString(), value.toString()));
    result = jsonEncode(stringMap);
    return result;
  }

  MatchUser? findBestMatch(
      List<MatchUser> historyUsers, List<MatchUser> currentUsers) {
    // for (var user in historyUsers) {
    //   debugPrint('Tên: ${user.user?.name}');
    //   debugPrint('Sở thích: ${user.user?.hobby}');
    //   debugPrint('Chiều cao: ${user.user?.height}');
    //   debugPrint('Tuổi: ${user.user?.age}');
    //   debugPrint('Công việc: ${user.user?.job}');
    //   debugPrint('Khoảng cách: ${user.distance}');
    //   debugPrint('---------------------------------');
    // }
    double maxScore = double.negativeInfinity;
    MatchUser? bestMatch;

    for (final currentUser in currentUsers) {
      if (currentUser.user == null) continue;
      // debugPrint('Tên: ${currentUser.user?.name}');
      double score = calculateTotalScore(currentUser, historyUsers);
      // debugPrint('---------------------------------');
      if (score > maxScore) {
        maxScore = score;
        bestMatch = currentUser;
      }
    }
    return bestMatch;
  }

  double calculateTotalScore(
      MatchUser currentUser, List<MatchUser> historyUsers) {
    // Tính điểm categorical
    double hobbyScore = calculateTfIdf(
        currentUser.user?.hobby.split(', ') ?? [],
        historyUsers.map((e) => e.user?.hobby.split(', ') ?? []).toList());
    double jobScore = calculateTfIdf([currentUser.user?.job ?? ''],
        historyUsers.map((e) => [e.user?.job ?? '']).toList());

    // Tính điểm numerical
    final userHeight =
        double.tryParse(currentUser.user?.height.replaceAll('cm', '') ?? '') ??
            0;
    final meanDistance =
        caculateMean(historyUsers.map((e) => e.distance).toList());
    final meanAge = caculateMean(
      historyUsers.map((e) => (e.user?.age ?? 0).toDouble()).toList(),
    );
    final meanHeight = caculateMean(
      historyUsers
          .map((e) =>
              double.tryParse(e.user?.height.replaceAll('cm', '') ?? '') ?? 0)
          .toList(),
    );
    final stdDevDistance =
        caculateStdDev(historyUsers.map((e) => e.distance).toList());
    final stdDevAge = caculateStdDev(
        historyUsers.map((e) => (e.user?.age ?? 0).toDouble()).toList());
    final stdDevHeight = caculateStdDev(historyUsers
        .map((e) =>
            double.tryParse(e.user?.height.replaceAll('cm', '') ?? '') ?? 0)
        .toList());
    double distanceScore =
        calculateScore(currentUser.distance, meanDistance, stdDevDistance);
    double ageScore = calculateScore(
        (currentUser.user?.age ?? 0).toDouble(), meanAge, stdDevAge);
    double heightScore = calculateScore(userHeight, meanHeight, stdDevHeight);

    // debugPrint('Sở thích: $hobbyScore');
    // debugPrint('Chiều cao: $heightScore');
    // debugPrint('Tuổi: $ageScore');
    // debugPrint('Khoảng cách: $distanceScore');
    // debugPrint('Công việc: $jobScore');
    // debugPrint('Tổng: ${hobbyScore + jobScore + distanceScore + ageScore + heightScore}');

    return hobbyScore + jobScore + distanceScore + ageScore + heightScore;
  }

  double calculateTfIdf(List<String> terms, List<List<String>> allTerms) {
    double totalScore = 0;
    int totalDocuments = allTerms.length;

    // Flatten the list of all terms for frequency counting
    List<String> flattenedTerms = allTerms.expand((list) => list).toList();

    for (String term in terms) {
      int termFrequency = flattenedTerms.where((t) => t == term).length;
      int documentContainingTerm =
          allTerms.where((userTerms) => userTerms.contains(term)).length;

      // Calculate TF and IDF
      double tf = termFrequency / flattenedTerms.length;
      double idf = math.log(totalDocuments /
          (documentContainingTerm == 0 ? 1 : documentContainingTerm));

      // Aggregate scores
      totalScore += tf * idf;
    }

    return totalScore;
  }

  double calculateScore(double x, double mean, double stdDev) {
    return math.exp(-(math.pow((x - mean), 2) / (2 * math.pow(stdDev, 2))));
  }

  double caculateMean(List<double> values) {
    return values.reduce((a, b) => a + b) / values.length;
  }

  double caculateStdDev(List<double> values) {
    double mean = caculateMean(values);
    double variance =
        values.map((e) => math.pow(e - mean, 2)).reduce((a, b) => a + b) /
            values.length;
    return math.sqrt(variance);
  }
}
