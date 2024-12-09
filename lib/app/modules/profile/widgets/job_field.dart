import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/profile/profile_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';

class JobField extends StatelessWidget {
  const JobField({
    super.key,
    required this.signInController,
    required this.profileController,
  });

  final SignInController signInController;
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: signInController.user.job != ''
          ? signInController.user.job
          : null,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Job',
        labelStyle: CustomTextStyle.h3(AppColors.thirdColor),
      ),
      isExpanded: true,
      items: [
        'Software Engineer',
        'Graphic Designer',
        'Marketing Specialist',
        'Teacher',
        'Nurse',
        'Sales Manager',
        'Data Analyst',
        'Chef',
        'Architect',
        'Lawyer',
        'Product Manager',
        'Accountant',
        'Photographer',
        'Social Media Manager',
        'Entrepreneur',
        'Mechanical Engineer',
        'Writer',
        'Doctor',
        'UX/UI Designer',
        'Real Estate Agent'
      ].map(
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
        profileController.UpdateJob(value!);
      },
    );
  }
}
