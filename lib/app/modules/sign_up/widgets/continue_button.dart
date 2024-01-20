import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/sign_up/sign_up_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContinueButton extends StatelessWidget {
  ContinueButton({
    super.key,
  });
  final SignUpController signUpController = Get.find<SignUpController>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100.h),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(60.r),
      ),
      child: ElevatedButton(
        onPressed: () async {
          try {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: signUpController.verificationId.value,
                smsCode: signUpController.smsCode.value);
            await auth.signInWithCredential(credential);
            signUpController.UpdateUserId(auth.currentUser!.uid);
            Get.toNamed(AppRoutes.password);
          } catch (ex) {
            signUpController.UpdateCheckOTP();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r)),
        ),
        child: Text(
          'CONTINUE',
          style: TextStyle(
            fontSize: 30.sp,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
