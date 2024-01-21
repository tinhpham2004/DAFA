import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/profile/profile_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';

class BioField extends StatelessWidget {
  const BioField({
    super.key,
    required this.profileController,
    required this.signInController,
  });

  final ProfileController profileController;
  final SignInController signInController;

  @override
  Widget build(BuildContext context) {
    profileController.bio.text = signInController.user.bio;
    return TextField(
      controller: profileController.bio,
      style: CustomTextStyle.h3(AppColors.black),
      decoration: InputDecoration(
        labelText: 'Describe yourself',
        labelStyle: CustomTextStyle.h3(AppColors.thirdColor),
        border: InputBorder.none,
      ),
    );
  }
}
