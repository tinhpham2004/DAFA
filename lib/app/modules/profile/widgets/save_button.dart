import 'dart:io';

import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/profile/profile_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SaveButton extends StatelessWidget {
  SaveButton({
    super.key,
  });
  DatabaseService databaseService = DatabaseService();
  final SignInController signInController = Get.find<SignInController>();
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.h, right: 30.w, bottom: 40.h),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(60.r),
      ),
      child: ElevatedButton(
        onPressed: () async {
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
          List<String> images = [];
          int count = 0;

          for (int index = 0; index < 6; index++) {
            if (profileController.imgUrl[index].value.contains(
                'https://firebasestorage.googleapis.com/v0/b/dafa-98847.appspot.com')) {
              images.add(profileController.imgUrl[index].value);
              continue;
            }
            if (profileController.imgUrl[index].value == '') {
              count++;
              continue;
            }
            String fileName = DateTime.now().microsecondsSinceEpoch.toString();
            Reference referenceRoot = FirebaseStorage.instance.ref();
            Reference referenceFolderImage = referenceRoot
                .child('${signInController.phoneNumberController.text}');
            Reference referenceImage = referenceFolderImage.child(fileName);
            await referenceImage.putFile(
                File(profileController.imgUrl[index].value),
                SettableMetadata(contentType: 'image/jpeg'));
            images.add(await referenceImage.getDownloadURL());
          }
          if (count > 3) {
            profileController.UpdateErrorImages(true);
          } else {
            signInController.user.bio = profileController.bio.text;
            signInController.user.height = profileController.height.value;
            signInController.user.hobby = profileController.hobby.value;
            signInController.user.job = profileController.job.value;
            signInController.user.images = images;
            await databaseService.UpdateUserData(signInController.user);
            profileController.UpdateErrorImages(false);
            for (int index = 0; index < images.length; index++) {
              profileController.UpdateImgUrl(index, images[index]);
            }
          }
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r)),
        ),
        child: Text(
          'SAVE',
          style: TextStyle(
            fontSize: 30.sp,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
