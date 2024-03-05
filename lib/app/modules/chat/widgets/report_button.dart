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
              if (await databaseService.IsReported(chatController
                      .compatibleUserList[chatController.currIndex.value]
                      .user!
                      .phoneNumber) ==
                  false) {
                if (await openAIService.CommunityRulesViolationCheck(
                        chatController.reportMessages) ==
                    true) {
                  await databaseService.Report(chatController
                      .compatibleUserList[chatController.currIndex.value]
                      .user!
                      .phoneNumber);
                  if (await databaseService.CanBeBanned(chatController
                      .compatibleUserList[chatController.currIndex.value]
                      .user!
                      .phoneNumber)) {
                    databaseService.BanUser(chatController
                        .compatibleUserList[chatController.currIndex.value]
                        .user!
                        .phoneNumber);
                  }
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 300.h,
                                child: Icon(
                                  Icons.check,
                                  size: 100.sp,
                                  color: AppColors.white,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.active,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 40.h),
                                child: Text(
                                  'Your report has been submitted successfully. We take community safety seriously and will address this issue accordingly.',
                                  style: CustomTextStyle.cardTextStyle(
                                    AppColors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 300.h,
                                child: Icon(
                                  Icons.close,
                                  size: 100.sp,
                                  color: AppColors.white,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 40.h),
                                child: Text(
                                  'Thank you for bringing this to our attention. We have reviewed the user\'s activity and haven\'t found any violations of our community guidelines at this time.',
                                  style: CustomTextStyle.cardTextStyle(
                                    AppColors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              } else {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 300.h,
                              child: Icon(
                                Icons.warning_rounded,
                                size: 100.sp,
                                color: AppColors.white,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.warning,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 40.h),
                              child: Text(
                                'Looks like you\'ve already flagged this user\'s behavior. We\'re on it! Rest assured, we take all reports seriously.',
                                style: CustomTextStyle.cardTextStyle(
                                  AppColors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 20.h, bottom: 40.h),
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(
              color: chatController.reportCheckbox.value == true
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
