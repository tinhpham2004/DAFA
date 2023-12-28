import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/sign_up/sign_up_controller.dart';
import 'package:dafa/app/modules/sign_up/widgets/back_icon.dart';
import 'package:dafa/app/modules/sign_up/widgets/password_field.dart';
import 'package:dafa/app/modules/sign_up/widgets/sign_up_button.dart';
import 'package:flutter/material.dart';
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter your password',
                        style: CustomTextStyle.h1(Colors.black),
                      ),

                      //
                      SizedBox(
                        width: 300,
                        child: PasswordField(),
                      ),

                      Obx(
                        () => Container(
                          margin: const EdgeInsets.only(top: 20),
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
