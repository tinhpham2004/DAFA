import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/services/openAI_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMessageField extends StatelessWidget {
  AddMessageField({
    super.key,
    required this.chatController,
  });

  final ChatController chatController;
  final openAIService = OpenAIService();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: chatController.messageController,
      decoration: InputDecoration(
        suffix: GestureDetector(
          onTap: () async {
            String message =
                await openAIService.SuggestRep(chatController.lastestMessage);
            chatController.UpdateSuggestRep(message);
          },
          child: Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: AppColors.send,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lightbulb,
              size: 40.sp,
              color: AppColors.white,
            ),
          ),
        ),
        hintText: 'Add message...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.r),
        ),
      ),
    );
  }
}
