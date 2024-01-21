import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/sign_up/sign_up_controller.dart';
import 'package:dafa/app/modules/sign_up/widgets/back_icon.dart';
import 'package:dafa/app/modules/sign_up/widgets/continue_button.dart';
import 'package:dafa/app/modules/sign_up/widgets/otp_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});

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
                        'My OTP code is',
                        style: CustomTextStyle.h1(Colors.black),
                      ),

                      //
                      Container(
                        margin: EdgeInsets.only(top: 100.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 60.h,
                              width: 80.w,
                              child: OTPField(
                                smsController: signUpController.smsCode1,
                              ),
                            ),
                            SizedBox(
                              height: 60.h,
                              width: 80.w,
                              child: OTPField(
                                smsController: signUpController.smsCode2,
                              ),
                            ),
                            SizedBox(
                              height: 60.h,
                              width: 80.w,
                              child: OTPField(
                                smsController: signUpController.smsCode3,
                              ),
                            ),
                            SizedBox(
                              height: 60.h,
                              width: 80.w,
                              child: OTPField(
                                smsController: signUpController.smsCode4,
                              ),
                            ),
                            SizedBox(
                              height: 60.h,
                              width: 80.w,
                              child: OTPField(
                                smsController: signUpController.smsCode5,
                              ),
                            ),
                            SizedBox(
                              height: 60.h,
                              width: 80.w,
                              child: OTPField(
                                smsController: signUpController.smsCode6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //
                      Obx(
                        () => Container(
                          margin: EdgeInsets.only(top: 20.h),
                          child: signUpController.checkOTP.value == true
                              ? Text(
                                  'Please enter the 6-digit OTP code we sent you. It expires in 2 minutes.',
                                  style:
                                      CustomTextStyle.h3(AppColors.thirdColor),
                                )
                              : Text(
                                  'Wrong OTP code, please check your SMS message.',
                                  style: CustomTextStyle.error_text_style(),
                                ),
                        ),
                      ),
                      //
                      ContinueButton(),
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
