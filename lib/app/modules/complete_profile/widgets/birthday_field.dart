import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BirthdayField extends StatelessWidget {
  BirthdayField({super.key, required controller})
      : dateOfBirthController = controller;

  final TextEditingController dateOfBirthController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateOfBirthController,
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
