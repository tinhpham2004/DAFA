import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OTPField extends StatelessWidget {
  OTPField({
    super.key,
  });
  final SignUpController signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (value.length == 1) {
          signUpController.UpdateSmsCode(value);
          FocusScope.of(context).nextFocus();
        }
      },
      style: CustomTextStyle.h2(AppColors.secondaryColor),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [LengthLimitingTextInputFormatter(1)],
    );
  }
}
