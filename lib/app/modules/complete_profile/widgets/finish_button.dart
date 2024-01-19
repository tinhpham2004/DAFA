import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/complete_profile/complete_profile_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FinishButton extends StatelessWidget {
  FinishButton({
    super.key,
  });
  final CompleteProfileController completeProfileController =
      Get.find<CompleteProfileController>();
  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100.h),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(60.r),
      ),
      child: ElevatedButton(
        onPressed: () async {
          await databaseService.UpdateUserImage(
              1, completeProfileController.imgDownloadUrl1.value);
          await databaseService.UpdateUserImage(
              2, completeProfileController.imgDownloadUrl2.value);
          await databaseService.UpdateUserImage(
              3, completeProfileController.imgDownloadUrl3.value);
          await databaseService.UpdateUserImage(
              4, completeProfileController.imgDownloadUrl4.value);
          await databaseService.UpdateUserImage(
              5, completeProfileController.imgDownloadUrl5.value);
          await databaseService.UpdateUserImage(
              6, completeProfileController.imgDownloadUrl6.value);
          Get.toNamed(AppRoutes.swipe);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r)),
        ),
        child: Text(
          'FINSIH',
          style: TextStyle(
            fontSize: 30.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
