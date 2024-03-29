import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/sign_up/sign_up_controller.dart';
import 'package:dafa/app/modules/sign_up/widgets/back_icon.dart';
import 'package:dafa/app/modules/sign_up/widgets/phone_number_field.dart';
import 'package:dafa/app/modules/sign_up/widgets/send_otp_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

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
                        margin: EdgeInsets.only(left: 200.w, top: 80.h),
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
                        'My number is',
                        style: CustomTextStyle.h1(Colors.black),
                      ),

                      //

                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 52.h),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: AppColors.secondaryColor,
                            ))),
                            child: Text(
                              '+84',
                              style:
                                  CustomTextStyle.h2(AppColors.secondaryColor),
                            ),
                          ),
                          Container(
                            width: 460.w,
                            margin: EdgeInsets.only(left: 40.h),
                            child: PhoneNumberField(
                              phoneNumberController:
                                  signUpController.phoneNumberController,
                            ),
                          ),
                        ],
                      ),

                      //
                      Obx(() => Container(
                            margin: EdgeInsets.only(top: 100.h),
                            child: signUpController.validPhoneNumber.value == 0
                                ? Text(
                                    'We will send a text with verification code via this phone number.',
                                    style: CustomTextStyle.h3(
                                        AppColors.thirdColor),
                                  )
                                : signUpController.validPhoneNumber.value == 1
                                    ? Text(
                                        'The phone number you entered is already associated with an account. Please log in or use a different number.',
                                        style:
                                            CustomTextStyle.error_text_style(),
                                      )
                                    : Text(
                                        'Uh oh! You\'ve reached the maximum number of OTP requests allowed for your phone number in a 24-hour period. Please try again in 24 hours.',
                                        style:
                                            CustomTextStyle.error_text_style(),
                                      ),
                          )),

                      //
                      SendOTPButton(),
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
