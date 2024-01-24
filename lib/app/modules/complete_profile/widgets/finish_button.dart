import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/models/app_user.dart';
import 'package:dafa/app/models/match_user.dart';
import 'package:dafa/app/modules/complete_profile/complete_profile_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/location_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FinishButton extends StatelessWidget {
  FinishButton({
    super.key,
  });
  final CompleteProfileController completeProfileController =
      Get.find<CompleteProfileController>();
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
          List<String> images = [];
          int count = 0;

          for (int index = 0; index < 6; index++) {
            if (completeProfileController.imgUrl[index].value == '') {
              count++;
              continue;
            }
            String fileName = DateTime.now().microsecondsSinceEpoch.toString();
            Reference referenceRoot = FirebaseStorage.instance.ref();
            Reference referenceFolderImage = referenceRoot
                .child('${signInController.phoneNumberController.text}');
            Reference referenceImage = referenceFolderImage.child(fileName);
            await referenceImage.putFile(
                File(completeProfileController.imgUrl[index].value),
                SettableMetadata(contentType: 'image/jpeg'));
            images.add(await referenceImage.getDownloadURL());
          }
          if (count > 3) {
            completeProfileController.UpdateErrorImages(true);
          } else {
            String name = completeProfileController.name.text;
            String dateOfBirth = completeProfileController.dateOB1.text +
                completeProfileController.dateOB2.text +
                "/" +
                completeProfileController.dateOB3.text +
                completeProfileController.dateOB4.text +
                "/" +
                completeProfileController.dateOB5.text +
                completeProfileController.dateOB6.text +
                completeProfileController.dateOB7.text +
                completeProfileController.dateOB8.text;
            String gender = '';
            if (completeProfileController.gender.value == 1)
              gender = "Man";
            else if (completeProfileController.gender.value == 2)
              gender = "Woman";
            else if (completeProfileController.gender.value == 3)
              gender = "LGBT";
            signInController.user.images = images;
            signInController.user.name = name;
            signInController.user.dateOfBirth = dateOfBirth;
            signInController.user.gender = gender;
            signInController.user.phoneNumber =
                signInController.phoneNumberController.text;
            Position coordinate = await locationService.GetCoordinate();
            signInController.user.coordinate =
                GeoPoint(coordinate.latitude, coordinate.longitude);
            signInController.user.address = await locationService.GetAddress();
            databaseService.UpdateUserData(signInController.user);
            await databaseService.LoadMatchedList();
            signInController.matchList =
                await databaseService.LoadMatchList(signInController.user);
            signInController.matchList.add(
              MatchUser(
                user: null,
                distance: 0,
              ),
            );
            Get.toNamed(AppRoutes.swipe);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r)),
        ),
        child: Text(
          'FINSIH',
          style: TextStyle(
            fontSize: 30.sp,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
