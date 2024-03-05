import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordField extends StatelessWidget {
  PasswordField({
    super.key,
  });

  final SignInController signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              signInController.UpdateObscure(!signInController.obscure.value);
            },
            icon: signInController.obscure.value == true
                ? Icon(Icons.remove_red_eye_rounded)
                : Icon(
                    Icons.remove_red_eye_rounded,
                    color: AppColors.disabledBackground,
                  ),
          ),
        ),
        obscureText: signInController.obscure.value,
        controller: signInController.passwordController,
      ),
    );
  }
}
