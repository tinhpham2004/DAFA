import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/complete_profile/widgets/back_icon.dart';
import 'package:dafa/app/modules/complete_profile/widgets/continue_button.dart';
import 'package:dafa/app/modules/complete_profile/widgets/lgbt_button.dart';
import 'package:dafa/app/modules/complete_profile/widgets/man_button.dart';
import 'package:dafa/app/modules/complete_profile/widgets/woman_button.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({super.key});

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
                        'I am a',
                        style: CustomTextStyle.h1(Colors.black),
                      ),
                      //

                      ManButton(),
                      WomanButton(),
                      LGBTButton(),

                      //
                      Container(
                        margin: EdgeInsets.only(top: 100.h),
                        child: Text(
                          'Please, select your gender.',
                          style: CustomTextStyle.h3(AppColors.thirdColor),
                        ),
                      ),

                      //
                      ContinueButton(route: AppRoutes.complete_upload_images),
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
