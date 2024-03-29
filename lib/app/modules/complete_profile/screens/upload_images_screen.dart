import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/complete_profile/complete_profile_controller.dart';
import 'package:dafa/app/modules/complete_profile/widgets/add_image.dart';
import 'package:dafa/app/modules/complete_profile/widgets/back_icon.dart';
import 'package:dafa/app/modules/complete_profile/widgets/finish_button.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UploadImagesScreen extends StatelessWidget {
  UploadImagesScreen({super.key});
  final CompleteProfileController completeProfileController =
      Get.find<CompleteProfileController>();
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Add photos',
                        style: CustomTextStyle.h1(AppColors.black),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 60.h),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 0.75,
                          children: List.generate(6, (index) {
                            return AddImage(index: index);
                          }),
                        ),
                      ),
                      //
                      Obx(
                        () => Container(
                          margin: EdgeInsets.only(top: 100.h),
                          child: completeProfileController.errorImages.value ==
                                  false
                              ? Text(
                                  'Please, select at least 3 photos.',
                                  style:
                                      CustomTextStyle.h3(AppColors.thirdColor),
                                )
                              : Text(
                                  'Please, select at least 3 photos.',
                                  style: CustomTextStyle.error_text_style(),
                                ),
                        ),
                      ),
                      //
                      FinishButton(),
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
