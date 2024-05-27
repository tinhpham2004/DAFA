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
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickPhotoButton extends StatelessWidget {
  PickPhotoButton({
    super.key,
  });

  final SignInController signInController = Get.find<SignInController>();
  final ChatController chatController = Get.find<ChatController>();
  DatabaseService databaseService = DatabaseService();
  final messagesCollection = FirebaseFirestore.instance.collection('messages');

  void SendMessage(String imgURL, String type) {
    String index = messagesCollection.doc().id;
    Message message = Message(
      id: index,
      sender: signInController.user.phoneNumber,
      receiver: chatController
          .compatibleUserList[chatController.currIndex.value].user!.phoneNumber,
      content: imgURL,
      time: DateTime.now(),
      category: type,
    );

    final firebaseMessagingService = FirebaseMessagingService();
    firebaseMessagingService.SendNotification(
        signInController.user.name,
        type == 'image' ? "[Hình ảnh]" : "[Video]",
        signInController.user.phoneNumber,
        chatController
            .compatibleUserList[chatController.currIndex.value].user!.token);
    databaseService.SendMessage(message);
  }

  String getType(String name) {
    String type = '';
    for (int i = name.length - 1; i >= 0; i--) {
      if (name[i] == '.') {
        type = name.substring(i + 1, name.length);
        break;
      }
    }

    if (type == 'jpg' ||
        type == 'jpeg' ||
        type == 'gif' ||
        type == 'png' ||
        type == 'svg')
      return 'image';
    else
      return 'video';
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
          final file = await ImagePicker().pickMedia();
          if (file == null) return;
          final type = getType(file.name);
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
              File(file.path),
              SettableMetadata(
                  contentType: type == 'image' ? 'image/jpeg' : 'video/mp4'));
          final downloadURL = await referenceImage.getDownloadURL();
          SendMessage(downloadURL, type);
        },
        icon: Icon(
          Icons.image,
          color: AppColors.white,
        ),
      ),
    );
  }
}
