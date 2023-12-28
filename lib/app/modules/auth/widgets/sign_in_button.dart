import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
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
          color: Colors.white,
          width: 2,
        ),
      ),
      child: const Text(
        'SIGN IN',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
