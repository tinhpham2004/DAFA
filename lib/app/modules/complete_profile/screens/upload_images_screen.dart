import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/complete_profile/widgets/back_icon.dart';
import 'package:dafa/app/modules/complete_profile/widgets/continue_button.dart';
import 'package:dafa/app/modules/complete_profile/widgets/fifth_add_image_button.dart';
import 'package:dafa/app/modules/complete_profile/widgets/finish_button.dart';
import 'package:dafa/app/modules/complete_profile/widgets/first_add_image_button.dart';
import 'package:dafa/app/modules/complete_profile/widgets/fourth_add_image_button.dart';
import 'package:dafa/app/modules/complete_profile/widgets/second_add_image_button.dart';
import 'package:dafa/app/modules/complete_profile/widgets/sixth_add_image_button.dart';
import 'package:dafa/app/modules/complete_profile/widgets/third_add_image_button.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UploadImagesScreen extends StatelessWidget {
  UploadImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: const BackIcon(),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 110, top: 40),
                        child: AppIcons.logo,
                      ),
                    ],
                  ),
                ),

                //
                Container(
                  margin: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Add photos',
                        style: CustomTextStyle.h1(Colors.black),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            FirstAddImageButton(),
                            SecondAddImageButton(),
                            ThirdAddImageButton(),
                          ],
                        ),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            FourthAddImageButton(),
                            FifthAddImageButton(),
                            SixthAddImageButton(),
                          ],
                        ),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Text(
                          'Please, select at least 3 photos.',
                          style: CustomTextStyle.h3(AppColors.thirdColor),
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
