import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/models/message.dart';
import 'package:dafa/app/modules/anonymous_chat/anonymous_chat_controller.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendMessageButton extends StatelessWidget {
  SendMessageButton({
    super.key,
  });
  final AnonymousChatController anonymousChatController =
      Get.find<AnonymousChatController>();
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
          receiver: signInController
              .matchList[anonymousChatController.currIndex.value]
              .user!
              .phoneNumber,
          content: anonymousChatController.messageController.text,
          time: DateTime.now(),
        );
        if (message.content != '') {
          databaseService.SendMessage(message);
          anonymousChatController.messageController.text = '';
        }
      },
    );
  }
}
