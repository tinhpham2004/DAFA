import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/models/app_user.dart';
import 'package:dafa/app/models/match_user.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/firebase_listener_service.dart';
import 'package:dafa/app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SignInButton extends StatelessWidget {
  SignInButton({
    super.key,
  });

  final SignInController signInController = Get.find<SignInController>();
  DatabaseService databaseService = DatabaseService();
  LocationService locationService = LocationService();
  FirebaseListenerService firebaseListenerService = FirebaseListenerService();
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
          if (signInController.signInState.value == 'Sign in successfully.') {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Dialog(
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                              top: 150.h,
                              bottom: 150.h,
                            ),
                            child: CircularProgressIndicator()),
                        Container(
                          margin: EdgeInsets.only(bottom: 40.h),
                          child: Text(
                            'Please, wait for a moment!',
                            style: CustomTextStyle.cardTextStyle(
                              AppColors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
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
              signInController.user.isOnline = true;
              signInController.user.lastActive = DateTime.now();
              await databaseService.UpdateUserData(signInController.user);
              await databaseService.LoadMatchedList();
              signInController.matchList =
                  await databaseService.LoadMatchList(signInController.user);
              firebaseListenerService.LoadAllUsersOnlineState();
              firebaseListenerService.LoadAllUsersSearchingState();
              firebaseListenerService.LoadGraphMatchList();
              signInController.matchList.add(
                MatchUser(
                  user: null,
                  distance: 0,
                ),
              );
              try {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString(
                    "phoneNumber", signInController.user.phoneNumber);
              } catch (error) {
                print("Error: " + error.toString());
              }
              signInController.phoneNumberController = TextEditingController();
              signInController.passwordController = TextEditingController();
              Get.back();
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
