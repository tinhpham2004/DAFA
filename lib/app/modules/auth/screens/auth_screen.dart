import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/modules/auth/widgets/sign_in_button.dart';
import 'package:dafa/app/modules/auth/widgets/sign_up_button.dart';
import 'package:flutter/material.dart';

class AuthnScreen extends StatelessWidget {
  const AuthnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(80, 200, 80, 20),
                  child: Row(
                    children: [
                      // icon
                      Icon(
                        AppIcons.logo.icon,
                        color: Colors.white,
                        size: 70,
                      ),
                      const Text(
                        'DAFA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // message
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: const Text(
                    'Welcome to DAFA where you can chat, make friends, and find your soulmate!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // sign_in button
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: SignInButton(),
                ),

                // sign_up button
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: SignUpButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




