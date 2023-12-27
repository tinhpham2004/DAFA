import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/sign_up/widgets/back_icon.dart';
import 'package:dafa/app/modules/sign_up/widgets/continue_button.dart';
import 'package:dafa/app/modules/sign_up/widgets/otp_field.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

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
                        'My OTP code is',
                        style: CustomTextStyle.h1(Colors.black),
                      ),

                      //
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 40,
                              child: OTPField(),
                            ),
                            SizedBox(
                              height: 30,
                              width: 40,
                              child: OTPField(),
                            ),
                            SizedBox(
                              height: 30,
                              width: 40,
                              child: OTPField(),
                            ),
                            SizedBox(
                              height: 30,
                              width: 40,
                              child: OTPField(),
                            ),
                            SizedBox(
                              height: 30,
                              width: 40,
                              child: OTPField(),
                            ),
                            SizedBox(
                              height: 30,
                              width: 40,
                              child: OTPField(),
                            ),
                          ],
                        ),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Please enter the otp code with 6 numbers that we sent you.',
                          style: CustomTextStyle.h3(AppColors.thirdColor),
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
