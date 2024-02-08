import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/models/message.dart';
import 'package:dafa/app/modules/chat_bot/chat_bot_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/openAI_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendMessageButton extends StatelessWidget {
  SendMessageButton({
    super.key,
  });

  final SignInController signInController = Get.find<SignInController>();
  final ChatBotController chatBotController = Get.find<ChatBotController>();
  final DatabaseService databaseService = DatabaseService();
  final OpenAIService openAIService = OpenAIService();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.send,
        color: AppColors.white,
      ),
      onPressed: () async {
        Message message = Message(
          sender: signInController.user.phoneNumber,
          receiver: 'chat_bot',
          content: chatBotController.messageController.text,
          time: DateTime.now(),
        );
        String tempMessage = chatBotController.messageController.text;
        if (message.content != '') {
          databaseService.SendMessage(message);
          chatBotController.messageController.text = '';
        }
        String chatBotReply = await openAIService.ChatBotReply(tempMessage);
        Message chatBotMessage = Message(
          sender: 'chat_bot',
          receiver: signInController.user.phoneNumber,
          content: chatBotReply,
          time: DateTime.now(),
        );
        databaseService.SendMessage(chatBotMessage);
      },
    );
  }
}
