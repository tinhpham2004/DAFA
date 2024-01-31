import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/anonymous_chat/anonymous_chat_controller.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LikeButton extends StatelessWidget {
  LikeButton({
    super.key,
  });
  final SignInController signInController = Get.find<SignInController>();
  final ChatController chatController = Get.find<ChatController>();
  final AnonymousChatController anonymousChatController =
      Get.find<AnonymousChatController>();
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (anonymousChatController.isFirstTimeLike == true) {
          anonymousChatController.UpdateIsFirstTimeLike(false);
          signInController.likeList.add(signInController
              .matchList[anonymousChatController.currIndex.value]
              .user!
              .phoneNumber);
          if (await databaseService.CheckIsLike(signInController
              .matchList[anonymousChatController.currIndex.value]
              .user!
              .phoneNumber)) {
            signInController.compatibleList.add(signInController
                .matchList[anonymousChatController.currIndex.value]
                .user!
                .phoneNumber);
            databaseService.UpdateCompatibleList(signInController
                .matchList[anonymousChatController.currIndex.value]
                .user!
                .phoneNumber);
            //
            int index = 0;
            if (chatController.compatibleUserList.length <
                signInController.compatibleList.length) {
              for (int i = 0;
                  i < signInController.matchListForChat.length;
                  i++) {
                for (int j = 0;
                    j < signInController.compatibleList.length;
                    j++) {
                  if (signInController.matchListForChat[i].user!.phoneNumber ==
                          signInController.compatibleList[j] &&
                      chatController.compatibleUserList
                              .contains(signInController.matchListForChat[i]) ==
                          false) {
                    chatController.compatibleUserList
                        .add(signInController.matchListForChat[i]);
                    if (signInController.compatibleList[j] ==
                        signInController
                            .matchList[anonymousChatController.currIndex.value]
                            .user!
                            .phoneNumber) {
                      index = chatController.compatibleUserList.length - 1;
                    }
                  }
                }
              }
            }
            chatController.UpdateCurrIndex(index);
            anonymousChatController.UpdateIsMatch(true);
            anonymousChatController.UpdateIsSearching(false);
            signInController.user.isSearching = false;
            databaseService.UpdateUserData(signInController.user);
            Get.toNamed(AppRoutes.message);
            //
          }
          databaseService.UpdateMatchedList();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 40.h),
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: anonymousChatController.isFirstTimeLike.value == true
              ? AppColors.pink
              : AppColors.disabledBackground,
        ),
        child: Icon(
          Icons.favorite,
          color: AppColors.white,
          size: 60.sp,
        ),
      ),
    );
  }
}
