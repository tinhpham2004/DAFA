import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOutButton extends StatelessWidget {
  SignOutButton({
    super.key,
  });

  final signInController = Get.find<SignInController>();
  final databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.exit_to_app_rounded,
        color: AppColors.black,
        size: 60.sp,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Sign out',
                style: CustomTextStyle.chatUserNameStyle(AppColors.black),
              ),
              content: Text(
                'Time to head out? We\'ll miss you! Sign out to return anytime.',
                style: CustomTextStyle.h3(AppColors.black),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Action when 'No' is pressed
                    Get.back();
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
                    signInController.user.isOnline = false;
                    databaseService.UpdateUserData(signInController.user);
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.remove("phoneNumber");
                    Get.back();
                    Get.deleteAll();
                    Get.offAllNamed(AppRoutes.auth);
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
                      )),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
