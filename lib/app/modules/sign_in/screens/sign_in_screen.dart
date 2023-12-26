import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryColor,
          ),
          child: Container(
            margin: const EdgeInsets.fromLTRB(100, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    // icon
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Icon(
                        AppIcons.logo.icon,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),
                    const Text(
                      'DAFA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
