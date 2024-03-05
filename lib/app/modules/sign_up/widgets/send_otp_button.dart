import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/sign_up/sign_up_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SendOTPButton extends StatelessWidget {
  SendOTPButton({
    super.key,
  });

  final SignUpController signUpController = Get.find<SignUpController>();
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: () async {
          if ((signUpController.phoneNumberController.text[0] == '0' &&
                  await databaseService.IsPhoneNumberExisted(
                          signUpController.phoneNumberController.text) ==
                      false) ||
              (signUpController.phoneNumberController.text[0] != '0' &&
                  await databaseService.IsPhoneNumberExisted(
                          '0${signUpController.phoneNumberController.text}') ==
                      false)) {
            try {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber:
                    '+84${signUpController.phoneNumberController.text}',
                timeout: const Duration(seconds: 120),
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {
                  signUpController.UpdateVerificationId(verificationId);
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
              Get.toNamed(AppRoutes.otp);
            } catch (error) {
              signUpController.UpdateValidPhoneNumber(2);
            }
          } else {
            signUpController.UpdateValidPhoneNumber(1);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        ),
        child: Text(
          'SEND OTP',
          style: TextStyle(
            fontSize: 30.sp,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
