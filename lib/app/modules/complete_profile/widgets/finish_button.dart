import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/models/app_user.dart';
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
          List<String> images = [
            completeProfileController.imgDownloadUrl1.value,
            completeProfileController.imgDownloadUrl2.value,
            completeProfileController.imgDownloadUrl3.value,
            completeProfileController.imgDownloadUrl4.value,
            completeProfileController.imgDownloadUrl5.value,
            completeProfileController.imgDownloadUrl6.value
          ];
          int count = 0;
          images.forEach((image) {
            if (image == '') count++;
          });
          if (count >= 3) {
            completeProfileController.UpdateErrorImages(true);
          } else {
            String name = completeProfileController.name.text;
            String dateOfBirth = completeProfileController.dateOB1.text +
                completeProfileController.dateOB2.text +
                "/" +
                completeProfileController.dateOB3.text +
                completeProfileController.dateOB4.text +
                "/" +
                completeProfileController.dateOB5.text +
                completeProfileController.dateOB6.text +
                completeProfileController.dateOB7.text +
                completeProfileController.dateOB8.text;
            String gender = '';
            if (completeProfileController.gender.value == 1)
              gender = "Man";
            else if (completeProfileController.gender.value == 2)
              gender = "Woman";
            else if (completeProfileController.gender.value == 3)
              gender = "LGBT";
            await databaseService.UpdateUserData(
                images, name, dateOfBirth, gender);
            Get.toNamed(AppRoutes.swipe);
          }
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
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
