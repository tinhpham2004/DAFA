import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/openAI_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportButton extends StatelessWidget {
  const ReportButton({
    super.key,
    required this.chatController,
    required this.databaseService,
    required this.openAIService,
  });

  final ChatController chatController;
  final DatabaseService databaseService;
  final OpenAIService openAIService;

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () async {
            if (chatController.reportCheckbox.value == true) {
              if (await databaseService.IsReported(
                      chatController
                          .compatibleUserList[
                              chatController.currIndex.value]
                          .user!
                          .phoneNumber) ==
                  false) {
                if (await openAIService
                        .CommunityRulesViolationCheck(
                            chatController.reportMessages) ==
                    true) {
                  databaseService.Report(chatController
                      .compatibleUserList[
                          chatController.currIndex.value]
                      .user!
                      .phoneNumber);
                  print('Success');
                } else {
                  print('Not violate community rules');
                }
              } else {
                print('You reported this person');
              }
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 20.h, bottom: 40.h),
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(
              color:
                  chatController.reportCheckbox.value == true
                      ? AppColors.red
                      : AppColors.disabledBackground,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Report',
              style: CustomTextStyle.communityRulesHeader(
                AppColors.white,
              ),
            ),
          ),
        ));
  }
}