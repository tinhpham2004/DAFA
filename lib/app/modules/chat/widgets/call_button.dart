import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_consts.dart';
import 'package:dafa/app/models/message.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/chat/screens/call_screen.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/firebase_messaging_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class CallButton extends StatelessWidget {
  CallButton({
    super.key,
    required this.isVideoCall,
  });
  final ChatController chatController = Get.find<ChatController>();
  final SignInController signInController = Get.find<SignInController>();
  final firebaseMessagingService = FirebaseMessagingService();
  final bool isVideoCall;
  final databaseService = DatabaseService();
  final messagesCollection = FirebaseFirestore.instance.collection('messages');

  Future<String> GetToken() async {
    String token = '';
    final response = await http.get(Uri.parse(isVideoCall == true
        ? '${AppConsts.agoraTokenBaseUrl}/access_token?channelName=videoCall${signInController.user.phoneNumber}${chatController.compatibleUserList[chatController.currIndex.value].user!.phoneNumber}'
        : '${AppConsts.agoraTokenBaseUrl}/access_token?channelName=audioCall${signInController.user.phoneNumber}${chatController.compatibleUserList[chatController.currIndex.value].user!.phoneNumber}'));
    if (response.statusCode == 200) {
      token = jsonDecode(response.body)['token'];
    }
    return token;
  }

  void SendCallInvitation(
      {required String channelName,
      required String token,
      required String callId}) {
    firebaseMessagingService.SendLocalCallNotification(
      title: signInController.user.name,
      body: isVideoCall == true ? 'Video call...' : 'Audio call...',
      receiverToken: chatController
          .compatibleUserList[chatController.currIndex.value].user!.token,
      callId: callId,
      channel: channelName,
      caller: signInController.user.phoneNumber,
      callee: chatController
          .compatibleUserList[chatController.currIndex.value].user!.phoneNumber,
      token: token,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await [Permission.microphone, Permission.camera].request();
        String channelName = isVideoCall == true
            ? 'videoCall${signInController.user.phoneNumber}${chatController.compatibleUserList[chatController.currIndex.value].user!.phoneNumber}'
            : 'audioCall${signInController.user.phoneNumber}${chatController.compatibleUserList[chatController.currIndex.value].user!.phoneNumber}';
        String token = await GetToken();
        String callId = messagesCollection.doc().id;
        Message message = Message(
          id: callId,
          sender: signInController.user.phoneNumber,
          receiver: chatController
              .compatibleUserList[chatController.currIndex.value]
              .user!
              .phoneNumber,
          content: 'waiting',
          time: DateTime.now(),
          category: isVideoCall == true ? 'videoCall' : 'audioCall',
        );
        await databaseService.SendMessage(message);
        Get.to(CallScreen(
          channelName: channelName,
          token: token,
          callId: callId,
        ));
        SendCallInvitation(
            channelName: channelName, token: token, callId: callId);
      },
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        padding: EdgeInsets.all(8.sp),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppColors.active),
        child: Icon(
          isVideoCall == true ? Icons.video_call_rounded : Icons.call,
          color: AppColors.white,
          size: 40.sp,
        ),
      ),
    );
  }
}
