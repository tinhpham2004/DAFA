import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/models/call.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/chat/screens/video_call_screen.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VideoCallButton extends StatelessWidget {
  VideoCallButton({
    super.key,
  });
  final ChatController chatController = Get.find<ChatController>();
  final SignInController signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(VideoCallScreen(
          calledUser: chatController
              .compatibleUserList[chatController.currIndex.value].user!,
          call: Call(
            id: null,
            channel:
                "videocall${signInController.user.phoneNumber}${chatController.compatibleUserList[chatController.currIndex.value].user!.phoneNumber}",
            caller: signInController.user.phoneNumber,
            called: chatController.compatibleUserList[chatController.currIndex.value].user!.phoneNumber,
            active: null,
            accepted: null,
            rejected: null,
            connected: null,
          ),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        padding: EdgeInsets.all(8.sp),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppColors.active),
        child: Icon(
          Icons.video_call_rounded,
          color: AppColors.white,
        ),
      ),
    );
  }
}
