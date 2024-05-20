import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/models/message.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/firebase_messaging_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TakePhotoButton extends StatelessWidget {
  TakePhotoButton({
    super.key,
  });

  final SignInController signInController = Get.find<SignInController>();
  final ChatController chatController = Get.find<ChatController>();
  DatabaseService databaseService = DatabaseService();
  final messagesCollection = FirebaseFirestore.instance.collection('messages');

  void SendMessage(String imgURL) {
    String index = messagesCollection.doc().id;
    Message message = Message(
      id: index,
      sender: signInController.user.phoneNumber,
      receiver: chatController
          .compatibleUserList[chatController.currIndex.value].user!.phoneNumber,
      content: imgURL,
      time: DateTime.now(),
      category: 'image',
    );

    final firebaseMessagingService = FirebaseMessagingService();
    firebaseMessagingService.SendNotification(
        signInController.user.name,
        "[Hình ảnh]",
        signInController.user.phoneNumber,
        chatController
            .compatibleUserList[chatController.currIndex.value].user!.token);
    databaseService.SendMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, bottom: 40.h),
      decoration: BoxDecoration(
        gradient: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () async {
          final file =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (file == null) return;
          // final croppedImg = await ImageCropper().cropImage(
          //   sourcePath: file.path,
          //   aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
          //   compressQuality: 100,
          // );
          // if (croppedImg == null) return;
          /////
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceFolderImage = referenceRoot
              .child('${signInController.phoneNumberController.text}');
          Reference referenceImage = referenceFolderImage.child(fileName);
          await referenceImage.putFile(
              File(file.path), SettableMetadata(contentType: 'image/jpeg'));
          final downloadURL = await referenceImage.getDownloadURL();
          SendMessage(downloadURL);
        },
        icon: Icon(
          Icons.camera_alt,
          color: AppColors.white,
        ),
      ),
    );
  }
}
