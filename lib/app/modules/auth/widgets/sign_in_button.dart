import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(AppRoutes.sign_in);
      },
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
        'SIGN IN',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
