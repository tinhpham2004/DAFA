import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/profile/profile_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';

class HobbyField extends StatelessWidget {
  const HobbyField({
    super.key,
    required this.signInController,
    required this.profileController,
  });

  final SignInController signInController;
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: signInController.user.hobby != ''
          ? signInController.user.hobby
          : null,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Hobby',
        labelStyle: CustomTextStyle.h3(AppColors.thirdColor),
      ),
      isExpanded: true,
      items: ['Gym', 'Yoga', 'Shopping', 'Video games', 'Chat', 'Coding'].map(
        (e) {
          return DropdownMenuItem(
            child: Text(
              e,
              style: CustomTextStyle.h3(
                AppColors.black,
              ),
            ),
            value: e,
          );
        },
      ).toList(),
      onChanged: (value) {
        profileController.UpdateHobby(value!);
      },
    );
  }
}
