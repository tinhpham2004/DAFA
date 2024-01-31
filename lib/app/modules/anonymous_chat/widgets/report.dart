import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/anonymous_chat/anonymous_chat_controller.dart';
import 'package:dafa/app/modules/anonymous_chat/widgets/report_button.dart';
import 'package:dafa/app/modules/chat/widgets/community_rules.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/openAI_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Report extends StatelessWidget {
  Report({
    super.key,
    required this.anonymousChatController,
  });

  final AnonymousChatController anonymousChatController;
  final OpenAIService openAIService = OpenAIService();
  final DatabaseService databaseService = DatabaseService();
  final SignInController signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        showModalBottomSheet(
          context: context,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Report',
                  style: CustomTextStyle.profileHeader(AppColors.black),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 40.w, right: 40.w),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20.h),
                        child: Text(
                          'Do you want to report ${signInController.matchList[anonymousChatController.currIndex.value].user!.name}?',
                          style: CustomTextStyle.cardTextStyle(AppColors.black),
                        ),
                      ),
                      Text(
                          'Thank you for your timely report and for helping to build a healthy dating app. We will review ${signInController.matchList[anonymousChatController.currIndex.value].user!.name}\'s recent messages. If we find that ${signInController.matchList[anonymousChatController.currIndex.value].user!.gender == 'Woman' ? 'her' : 'his'} account violates our community rules, we will take appropriate action. You should read the community rules carefully before taking the action of reporting.'),
                      Container(
                        margin: EdgeInsets.only(top: 40.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.thirdColor),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: CommunityRules(),
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          Obx(
                            () => Checkbox(
                              activeColor: AppColors.thirdColor,
                              value:
                                  anonymousChatController.reportCheckbox.value,
                              onChanged: (value) {
                                anonymousChatController.UpdateReportCheckbox(
                                    value!);
                              },
                              side: BorderSide(
                                color: AppColors.thirdColor,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 27.h),
                            child: Text(
                              'I have read the above content carefully.',
                              style: CustomTextStyle.h3(AppColors.black),
                            ),
                          )
                        ],
                      ),
                      ReportButton(
                          anonymousChatController: anonymousChatController,
                          databaseService: databaseService,
                          openAIService: openAIService),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      icon: Icon(
        Icons.warning_rounded,
        color: AppColors.red,
        size: 80.sp,
      ),
    );
  }
}
