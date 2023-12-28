import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/sign_in/widgets/sign_in_button.dart';
import 'package:dafa/app/modules/sign_in/widgets/password_field.dart';
import 'package:dafa/app/modules/sign_in/widgets/phone_number_field.dart';
import 'package:dafa/app/modules/sign_in/widgets/back_icon.dart';
import 'package:flutter/material.dart';
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
                        'My account is',
                        style: CustomTextStyle.h1(Colors.black),
                      ),

                      //
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Phone Number',
                          style: CustomTextStyle.h3(AppColors.secondaryColor),
                        ),
                      ),
                      Container(
                        width: 230,
                        margin: const EdgeInsets.only(left: 20),
                        child: PhoneNumberField(),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Password',
                          style: CustomTextStyle.h3(AppColors.secondaryColor),
                        ),
                      ),
                      Container(
                        width: 230,
                        margin: const EdgeInsets.only(left: 20),
                        child: PasswordField(),
                      ),

                      //
                      Obx(
                        () => Container(
                          margin: const EdgeInsets.only(top: 50),
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
