import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BlockButton extends StatelessWidget {
  const BlockButton({
    super.key,
    required this.databaseService,
    required this.chatController,
  });

  final DatabaseService databaseService;
  final ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Block',
                style: CustomTextStyle.chatUserNameStyle(AppColors.black),
              ),
              content: Text(
                'Are you sure you want to block ${chatController.compatibleUserList[chatController.currIndex.value].user!.name}',
                style: CustomTextStyle.h3(AppColors.black),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Action when 'No' is pressed
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 150.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: AppColors.active,
                        borderRadius: BorderRadius.circular(40.sp)),
                    child: Text(
                      'No',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await databaseService.Block(chatController
                        .compatibleUserList[chatController.currIndex.value]
                        .user!
                        .phoneNumber);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 150.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(30.sp)),
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
          margin: EdgeInsets.only(top: 20.h, left: 20.w),
          padding: EdgeInsets.all(8.sp),
          decoration:
              BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
          child: Icon(
            Icons.block,
            color: AppColors.white,
            size: 40.sp,
          )),
    );
  }
}
