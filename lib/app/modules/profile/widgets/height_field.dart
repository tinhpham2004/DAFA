import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/profile/profile_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';

class HeightField extends StatelessWidget {
  HeightField({
    super.key,
    required this.signInController,
    required this.profileController,
  });

  final SignInController signInController;
  final ProfileController profileController;
  List<String> height = List.generate(46, (index) {
    int value = 145 + index;
    return value.toString() + 'cm';
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: signInController.user.height != ''
          ? signInController.user.height
          : null,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Height',
        labelStyle: CustomTextStyle.h3(AppColors.thirdColor),
      ),
      isExpanded: true,
      items: height.map(
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
        profileController.UpdateHeight(value!);
      },
    );
  }
}
