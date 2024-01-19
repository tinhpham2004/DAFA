import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/modules/auth/widgets/sign_in_button.dart';
import 'package:dafa/app/modules/auth/widgets/sign_up_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  margin: EdgeInsets.fromLTRB(175.w, 300.h, 175.w, 75.h),
                  child: Row(
                    children: [
                      // icon
                      AppIcons.logo,
                      Text(
                        'DAFA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 100.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // message
                Container(
                  margin: EdgeInsets.only(top: 200.h),
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
                  margin: EdgeInsets.only(top: 50.h),
                  child: SignInButton(),
                ),

                // sign_up button
                Container(
                  margin: EdgeInsets.only(top: 50.h),
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
