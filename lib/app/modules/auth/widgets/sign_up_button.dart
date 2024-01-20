import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.toNamed(AppRoutes.sign_up),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(330, 50),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: const BorderSide(
          color: AppColors.white,
          width: 2,
        ),
      ),
      child: const Text(
        'SIGN UP',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}