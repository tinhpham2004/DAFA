import 'dart:math';

import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/complete_profile/complete_profile_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ContinueButton extends StatelessWidget {
  ContinueButton({
    super.key,
    required route,
  }) : _route = route;

  final String _route;
  DatabaseService databaseService = DatabaseService();
  final CompleteProfileController completeProfileController =
      Get.find<CompleteProfileController>();
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
        onPressed: () {
          if (_route == AppRoutes.complete_birth_day &&
              completeProfileController.name.text.length == 0) {
            completeProfileController.UpdateErrorName(true);
          } else if (_route == AppRoutes.complete_gerder &&
              (DateTime.tryParse(completeProfileController.dateOB5.text +
                          completeProfileController.dateOB6.text +
                          completeProfileController.dateOB7.text +
                          completeProfileController.dateOB8.text +
                          '-' +
                          completeProfileController.dateOB3.text +
                          completeProfileController.dateOB4.text +
                          '-' +
                          completeProfileController.dateOB1.text +
                          completeProfileController.dateOB2.text) ==
                      null ||
                  (DateTime.now().year -
                          DateTime.tryParse(
                                  completeProfileController.dateOB5.text +
                                      completeProfileController.dateOB6.text +
                                      completeProfileController.dateOB7.text +
                                      completeProfileController.dateOB8.text +
                                      '-' +
                                      completeProfileController.dateOB3.text +
                                      completeProfileController.dateOB4.text +
                                      '-' +
                                      completeProfileController.dateOB1.text +
                                      completeProfileController.dateOB2.text)!
                              .year) <
                      18)) {
            completeProfileController.UpdateErrorDate(true);
          } else if (_route == AppRoutes.complete_upload_images &&
              completeProfileController.gender.value == 0) {
            completeProfileController.UpdateErrorGender(true);
          } else {
            Get.toNamed(_route);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r)),
        ),
        child: Text(
          'CONTINUE',
          style: TextStyle(
            fontSize: 30.sp,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
