import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/models/app_user.dart';
import 'package:dafa/app/modules/sign_up/sign_up_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignUpButton extends StatelessWidget {
  SignUpButton({
    super.key,
  });
  final SignUpController signUpController = Get.find<SignUpController>();
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
          if (signUpController.passwordController.text.length >= 6 &&
              signUpController.passwordController.text
                  .contains(RegExp(r'[A-Z]')) &&
              signUpController.passwordController.text
                  .contains(RegExp(r'[a-z]')) &&
              signUpController.passwordController.text
                  .contains(RegExp(r'[0-9]'))) {
            AppUser user = AppUser(
              phoneNumber: signUpController.phoneNumberController.text,
            );
            if (user.phoneNumber[0] != '0')
              user.phoneNumber = '0' + user.phoneNumber;
            user.password = signUpController.passwordController.text;
            databaseService.InsertUserData(user);
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
                            'Cogratulations, your account has been successfully created!',
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
            Get.toNamed(AppRoutes.sign_in);
          } else {
            signUpController.UpdateValidPassword('Invalid password.');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r)),
        ),
        child: Text(
          'SIGN UP',
          style: TextStyle(
            fontSize: 30.h,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
