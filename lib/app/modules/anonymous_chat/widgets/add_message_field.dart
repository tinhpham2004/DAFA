import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/anonymous_chat/anonymous_chat_controller.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMessageField extends StatelessWidget {
  const AddMessageField({
    super.key,
    required this.anonymousChatController,
  });

  final AnonymousChatController anonymousChatController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: anonymousChatController.messageController,
      style: CustomTextStyle.messageStyle(AppColors.white),
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.backgroundColor,
          hintText: 'Add message...',
          hintStyle: CustomTextStyle.messageStyle(AppColors.thirdColor),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(60.r))),
    );
  }
}
