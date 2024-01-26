import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/services/openAI_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Report extends StatelessWidget {
  Report({
    super.key,
    required this.chatController,
  });

  final ChatController chatController;
  final OpenAIService openAIService = OpenAIService();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (await openAIService.CommunityRulesViolationCheck(
                chatController.reportMessages) ==
            true) {
          print("True");
        } else {
          print('False');
        }
      },
      icon: Icon(
        Icons.warning_rounded,
        color: AppColors.red,
        size: 80.sp,
      ),
    );
  }
}
