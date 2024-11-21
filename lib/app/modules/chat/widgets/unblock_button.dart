import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnblockButton extends StatelessWidget {
  const UnblockButton({
    super.key,
    required this.databaseService,
    required this.chatController,
  });

  final DatabaseService databaseService;
  final ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        databaseService.Unblock(chatController
            .compatibleUserList[chatController
                .currIndex.value]
            .user!
            .phoneNumber);
      },
      child: Container(
        height: 80.h,
        width: 700.w,
        decoration: BoxDecoration(
            color:
                AppColors.disabledBackground,
            borderRadius:
                BorderRadius.circular(30.sp)),
        padding: EdgeInsets.all(16.sp),
        margin: EdgeInsets.only(
            bottom: 40.h, top: 20.h),
        child: Text(
          'UNBLOCK',
          style: CustomTextStyle.messageStyle(
            AppColors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}