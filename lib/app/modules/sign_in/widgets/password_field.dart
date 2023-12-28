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
    return TextFormField(
      controller: signInController.passwordController,
    );
  }
}
