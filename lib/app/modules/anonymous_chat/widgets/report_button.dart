import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/anonymous_chat/anonymous_chat_controller.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/openAI_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportButton extends StatelessWidget {
  ReportButton({
    super.key,
    required this.anonymousChatController,
    required this.databaseService,
    required this.openAIService,
  });

  final AnonymousChatController anonymousChatController;
  final DatabaseService databaseService;
  final OpenAIService openAIService;
  final SignInController signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () async {
            if (anonymousChatController.reportCheckbox.value == true) {
              if (await databaseService.IsReported(signInController
                      .matchList[anonymousChatController.currIndex.value]
                      .user!
                      .phoneNumber) ==
                  false) {
                if (await openAIService.CommunityRulesViolationCheck(
                        anonymousChatController.reportMessages) ==
                    true) {
                  databaseService.Report(signInController
                      .matchList[anonymousChatController.currIndex.value]
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
              color: anonymousChatController.reportCheckbox.value == true
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
