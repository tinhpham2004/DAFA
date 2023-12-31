import 'dart:io';

import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/complete_profile/complete_profile_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FourthAddImageButton extends StatelessWidget {
  FourthAddImageButton({
    super.key,
  });

  final SignInController signInController = Get.find<SignInController>();
  final CompleteProfileController completeProfileController =
      Get.find<CompleteProfileController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (completeProfileController.imgUrl4.value == '') {
          final file =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (file == null) return;
          final croppedImg = await ImageCropper().cropImage(
            sourcePath: file.path,
            aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
            compressQuality: 100,
          );
          if (croppedImg == null) return;
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceFolderImage = referenceRoot
              .child('${signInController.phoneNumberController.text}');
          Reference referenceImage = referenceFolderImage.child(fileName);
          try {
            completeProfileController.UpdateImgUrl4(croppedImg.path);
            await referenceImage.putFile(File(croppedImg.path),
                SettableMetadata(contentType: 'image/jpeg'));
            completeProfileController.UpdateImgDownloadUrl4(
                await referenceImage.getDownloadURL());
          } catch (error) {
            print(error);
          }
        } else {
          completeProfileController.UpdateImgUrl4('');
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Obx(
              () => completeProfileController.imgUrl4.value == ''
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
                      child: Image.file(
                        File(completeProfileController.imgUrl4.value),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Obx(
              () => completeProfileController.imgUrl4.value == ''
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
