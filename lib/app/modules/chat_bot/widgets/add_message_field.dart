import 'package:dafa/app/modules/chat_bot/chat_bot_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddMessageField extends StatelessWidget {
  AddMessageField({
    super.key,
  });

  final ChatBotController chatBotController = Get.find<ChatBotController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: chatBotController.messageController,
      decoration: InputDecoration(
          hintText: 'Add message...',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(60.r))),
    );
  }
}
