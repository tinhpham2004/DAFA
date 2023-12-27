import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    required phoneNumberController,
  }) : _phoneNumberController = phoneNumberController;

  final TextEditingController _phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _phoneNumberController,
      keyboardType: TextInputType.phone,
      style: CustomTextStyle.h2(AppColors.secondaryColor),
      inputFormatters: [LengthLimitingTextInputFormatter(15)],
    );
  }
}