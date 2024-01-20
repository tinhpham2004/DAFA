import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/complete_profile/complete_profile_controller.dart';
import 'package:dafa/app/modules/complete_profile/widgets/back_icon.dart';
import 'package:dafa/app/modules/complete_profile/widgets/birthday_field.dart';
import 'package:dafa/app/modules/complete_profile/widgets/continue_button.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BirthDayScreen extends StatelessWidget {
  BirthDayScreen({super.key});

  final CompleteProfileController completeProfileController =
      Get.find<CompleteProfileController>();

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
                        'My birthday is',
                        style: CustomTextStyle.h1(Colors.black),
                      ),
                      //
                      Container(
                        width: 460.w,
                        margin: EdgeInsets.only(left: 40.w, top: 60.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60.h,
                              width: 40.w,
                              child: BirthdayField(
                                controller: completeProfileController.dateOB1,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              height: 60.h,
                              width: 40.w,
                              child: BirthdayField(
                                controller: completeProfileController.dateOB2,
                              ),
                            ),
                            //
                            Container(
                              margin: EdgeInsets.only(left: 8.w, bottom: 10.h),
                              child: Text(
                                '/',
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    color: AppColors.secondaryColor),
                              ),
                            ),
                            //
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              height: 60.h,
                              width: 40.w,
                              child: BirthdayField(
                                controller: completeProfileController.dateOB3,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              height: 60.h,
                              width: 40.w,
                              child: BirthdayField(
                                controller: completeProfileController.dateOB4,
                              ),
                            ),
                            //
                            Container(
                              margin: EdgeInsets.only(left: 8.w, bottom: 10.h),
                              child: Text(
                                '/',
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    color: AppColors.secondaryColor),
                              ),
                            ),
                            //
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              height: 60.h,
                              width: 40.w,
                              child: BirthdayField(
                                controller: completeProfileController.dateOB5,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              height: 60.h,
                              width: 40.w,
                              child: BirthdayField(
                                controller: completeProfileController.dateOB6,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              height: 60.h,
                              width: 40.w,
                              child: BirthdayField(
                                controller: completeProfileController.dateOB7,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              height: 60.h,
                              width: 40.w,
                              child: BirthdayField(
                                controller: completeProfileController.dateOB8,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //
                      Obx(
                        () => Container(
                          margin: EdgeInsets.only(top: 100.h),
                          child: completeProfileController.errorDate == false
                              ? Text(
                                  'Please, enter your birthday here so that other people can know your age.',
                                  style:
                                      CustomTextStyle.h3(AppColors.thirdColor),
                                )
                              : Text(
                                  'The date of birth you entered is invalid or you are not yet 18 years old.',
                                  style: CustomTextStyle.error_text_style(),
                                ),
                        ),
                      ),

                      //
                      ContinueButton(route: AppRoutes.complete_gerder),
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
