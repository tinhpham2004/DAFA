import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/global_widgets/bottom_navigation.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final SignInController signInController = Get.find<SignInController>();
  final ChatController chatController = Get.find<ChatController>();

  String LastActiveTime(Duration diff) {
    int year = (diff.inDays / 365).round();
    int month = (diff.inDays / 30).round();
    int day = diff.inDays;
    int hour = diff.inHours;
    int minute = diff.inMinutes;
    int second = diff.inSeconds;
    if (year > 0) {
      return year == 1 ? '1 year ago' : '$year years ago';
    }
    if (month > 0) {
      return month == 1 ? '1 month ago' : '$month months ago';
    }
    if (day > 0) {
      return day == 1 ? '1 day ago' : '$day days ago';
    }
    if (hour > 0) {
      return hour == 1 ? '1 hour ago' : '$hour hours ago';
    }
    if (minute > 0) {
      return minute == 1 ? '1 minute ago' : '$minute minutes ago';
    }
    if (second > 0) {
      return second == 1 ? '1 second ago' : '$minute seconds ago';
    }
    return 'just a moment';
  }

  @override
  Widget build(BuildContext context) {
    if (chatController.compatibleUserList.length <
        signInController.compatibleList.length) {
      for (int i = 0; i < signInController.matchListForChat.length; i++) {
        for (int j = 0; j < signInController.compatibleList.length; j++) {
          if (signInController.matchListForChat[i].user!.phoneNumber ==
                  signInController.compatibleList[j] &&
              chatController.compatibleUserList
                      .contains(signInController.matchListForChat[i]) ==
                  false) {
            chatController.compatibleUserList
                .add(signInController.matchListForChat[i]);
          }
        }
      }
    }
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            title: Text(
              'Messages',
              style: CustomTextStyle.profileHeader(AppColors.black),
            ),
          ),
          bottomNavigationBar: BottomNavigation(onItem: 2),
          body: Container(
            margin: EdgeInsets.only(top: 40.h, left: 40.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: chatController.compatibleUserList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          chatController.UpdateCurrIndex(index);
                          Get.toNamed(AppRoutes.message);
                        },
                        child: ListTile(
                          leading: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                height: 120.h,
                                width: 120.w,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(chatController
                                      .compatibleUserList[index]
                                      .user!
                                      .images
                                      .first),
                                ),
                              ),
                              Obx(() => Container(
                                    decoration: BoxDecoration(
                                      color: signInController
                                                      .listUsersOnlineState[
                                                  chatController
                                                      .compatibleUserList[index]
                                                      .user!
                                                      .phoneNumber] ==
                                              true
                                          ? AppColors.active
                                          : AppColors.disabledBackground,
                                      shape: BoxShape.circle,
                                    ),
                                    height: 20.h,
                                    width: 20.w,
                                  )),
                            ],
                          ),
                          title: Text(
                            chatController.compatibleUserList[index].user!.name,
                          ),
                          subtitle: Text(
                            'Last active • ' +
                                LastActiveTime(
                                  DateTime.now().difference(chatController
                                      .compatibleUserList[index]
                                      .user!
                                      .lastActive),
                                ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
