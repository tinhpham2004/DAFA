import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/models/message.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/firebase_messaging_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendMessageButton extends StatelessWidget {
  SendMessageButton({
    super.key,
  });
  final ChatController chatController = Get.find<ChatController>();
  final SignInController signInController = Get.find<SignInController>();
  DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.send,
        color: AppColors.white,
      ),
      onPressed: () {
        Message message = Message(
          sender: signInController.user.phoneNumber,
          receiver: chatController
              .compatibleUserList[chatController.currIndex.value]
              .user!
              .phoneNumber,
          content: chatController.messageController.text,
          time: DateTime.now(),
        );
        final firebaseMessagingService = FirebaseMessagingService();
        firebaseMessagingService.SendNotification(
            signInController.user.name,
            chatController.messageController.text,
            signInController.user.phoneNumber,
            chatController.compatibleUserList[chatController.currIndex.value]
                .user!.token);
        if (message.content != '') {
          databaseService.SendMessage(message);
          chatController.messageController.text = '';
        }
      },
    );
  }
}
