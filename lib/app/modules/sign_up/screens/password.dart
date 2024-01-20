import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/sign_up/sign_up_controller.dart';
import 'package:dafa/app/modules/sign_up/widgets/back_icon.dart';
import 'package:dafa/app/modules/sign_up/widgets/password_field.dart';
import 'package:dafa/app/modules/sign_up/widgets/sign_up_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordScreen extends StatelessWidget {
  PasswordScreen({super.key});

  final SignUpController signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                          top: 40.h,
                        ),
                        child: const BackIcon(),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 220.w, top: 80.h),
                        child: AppIcons.logo,
                      ),
                    ],
                  ),
                ),

                //
                Container(
                  margin: EdgeInsets.only(top: 100.h, left: 60.w, right: 60.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter your password',
                        style: CustomTextStyle.h1(Colors.black),
                      ),

                      //
                      SizedBox(
                        width: 600.w,
                        child: PasswordField(),
                      ),

                      Obx(
                        () => Container(
                          margin: EdgeInsets.only(top: 40.h),
                          child: signUpController.validPassword.isEmpty
                              ? Text(
                                  'Your password should be at leasest 6 characters and contain a mix of uppercase and lowercase letters, numbers, and symbols.',
                                  style:
                                      CustomTextStyle.h3(AppColors.thirdColor),
                                )
                              : Text(
                                  signUpController.validPassword.value,
                                  style: CustomTextStyle.error_text_style(),
                                ),
                        ),
                      ),
                      //
                      SignUpButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
