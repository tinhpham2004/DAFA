import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMessageField extends StatelessWidget {
  const AddMessageField({
    super.key,
    required this.chatController,
  });

  final ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: chatController.messageController,
      decoration: InputDecoration(
          hintText: 'Add message...',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(60.r))),
    );
  }
}
