import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/sign_in/widgets/sign_in_button.dart';
import 'package:dafa/app/modules/sign_in/widgets/password_field.dart';
import 'package:dafa/app/modules/sign_in/widgets/phone_number_field.dart';
import 'package:dafa/app/modules/sign_in/widgets/back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController signInController = Get.find<SignInController>();

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
                        'My account is',
                        style: CustomTextStyle.h1(AppColors.black),
                      ),

                      //
                      Container(
                        margin: EdgeInsets.only(top: 60.h),
                        child: Text(
                          'Phone Number',
                          style: CustomTextStyle.h3(AppColors.secondaryColor),
                        ),
                      ),
                      Container(
                        width: 230,
                        margin: EdgeInsets.only(left: 40.w),
                        child: PhoneNumberField(),
                      ),
                      //
                      Container(
                        margin: EdgeInsets.only(top: 60.h),
                        child: Text(
                          'Password',
                          style: CustomTextStyle.h3(AppColors.secondaryColor),
                        ),
                      ),
                      Container(
                        width: 460.w,
                        margin: EdgeInsets.only(left: 40.w),
                        child: PasswordField(),
                      ),

                      //
                      Obx(
                        () => Container(
                          margin: EdgeInsets.only(top: 100.h),
                          child: Text(
                            signInController.signInState.value,
                            style: signInController.signInState.value !=
                                    'The account or password is incorrect.'
                                ? CustomTextStyle.h3(AppColors.thirdColor)
                                : CustomTextStyle.error_text_style(),
                          ),
                        ),
                      ),

                      //
                      SignInButton(),
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
