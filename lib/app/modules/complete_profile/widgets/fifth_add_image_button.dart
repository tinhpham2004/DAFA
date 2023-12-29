import 'dart:io';

import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/complete_profile/complete_profile_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FifthAddImageButton extends StatelessWidget {
  FifthAddImageButton({
    super.key,
  });

  final SignInController signInController = Get.find<SignInController>();
  final CompleteProfileController completeProfileController =
      Get.find<CompleteProfileController>();
  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService();
    return GestureDetector(
      onTap: () async {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (file == null) return;
        String fileName = DateTime.now().microsecondsSinceEpoch.toString();
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceFolderImage = referenceRoot
            .child('${signInController.phoneNumberController.text}');
        Reference referenceImage = referenceFolderImage.child(fileName);
        try {
          await referenceImage.putFile(
              File(file.path), SettableMetadata(contentType: 'image/jpeg'));
          String imgUrl = await referenceImage.getDownloadURL();
          completeProfileController.UpdateImgUrl5(imgUrl);
          databaseService.UpdateUserImage(5, imgUrl);
        } catch (error) {
          print(error);
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Obx(
              () => completeProfileController.imgUrl5.value == ''
                  ? Container(
                      height: 120,
                      width: 90,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.thirdColor,
                      ),
                    )
                  : Container(
                      height: 120,
                      width: 90,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        completeProfileController.imgUrl5.string,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Obx(
              () => completeProfileController.imgUrl5.value == ''
                  ? Container(
                      decoration: BoxDecoration(
                          gradient: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(180)),
                      child: Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(180)),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.purple,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}