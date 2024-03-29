import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/complete_profile/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WomanButton extends StatelessWidget {
  WomanButton({
    super.key,
  });

  final CompleteProfileController completeProfileController =
      Get.find<CompleteProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100.h),
      width: double.infinity,
      child: Obx(
        () => ElevatedButton(
          onPressed: () {
            completeProfileController.UpdateGender(2);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(460.w, 100.h),
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.white,
            shadowColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.r),
              side: BorderSide(
                width: 2,
                color: completeProfileController.gender.value == 2
                    ? Colors.purple
                    : AppColors.thirdColor,
              ),
            ),
          ),
          child: Text(
            'WOMAN',
            style: TextStyle(
              fontSize: 30.sp,
              color: completeProfileController.gender.value == 2
                  ? Colors.purple
                  : AppColors.thirdColor,
            ),
          ),
        ),
      ),
    );
  }
}
