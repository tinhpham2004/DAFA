import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignInButton extends StatelessWidget {
  SignInButton({
    super.key,
  });

  final SignInController signInController = Get.find<SignInController>();
  DatabaseService databaseService = DatabaseService();
  LocationService locationService = LocationService();
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
          await databaseService.Authenticate(
            signInController.phoneNumberController.text,
            signInController.passwordController.text,
          );
          if (signInController.signInState == 'Sign in successfully.') {
            final bool isFirstTimeUpdate =
                await databaseService.FirstTimeUpdate();
            if (isFirstTimeUpdate) {
              Get.toNamed(AppRoutes.complete_name);
            } else {
              signInController.UpdateUser(await databaseService.LoadUserData());
              Position coordinate = await locationService.GetCoordinate();
              signInController.user.coordinate =
                  GeoPoint(coordinate.latitude, coordinate.longitude);
              signInController.user.address =
                  await locationService.GetAddress();
              await databaseService.UpdateUserData(signInController.user);
              signInController.matchList =
                  await databaseService.LoadMatchList(signInController.user);
              Get.toNamed(AppRoutes.swipe);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r)),
        ),
        child: Text(
          'SIGN IN',
          style: TextStyle(
            fontSize: 30.sp,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
