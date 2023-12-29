import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BirthdayField extends StatelessWidget {
  const BirthdayField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (value.length == 1) {
          //
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