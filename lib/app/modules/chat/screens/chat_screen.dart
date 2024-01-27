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

  @override
  Widget build(BuildContext context) {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                    chatController.UpdateCurrIndex(index);
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.message);
                      },
                      child: ListTile(
                        leading: Container(
                          height: 120.h,
                          width: 120.w,
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(chatController
                                  .compatibleUserList[index]
                                  .user!
                                  .images
                                  .first)),
                        ),
                        title: Text(
                          chatController.compatibleUserList[index].user!.name,
                        ),
                        subtitle: chatController.lastMessae[chatController
                                    .compatibleUserList[index]
                                    .user!
                                    .phoneNumber] !=
                                null
                            ? chatController
                                        .lastMessae[chatController
                                            .compatibleUserList[index]
                                            .user!
                                            .phoneNumber]!
                                        .sender ==
                                    signInController.user.phoneNumber
                                ? Text(
                                    'You: ${chatController.lastMessae[chatController.compatibleUserList[index].user!.phoneNumber]!.content} • ${chatController.lastMessae[chatController.compatibleUserList[index].user!.phoneNumber]!.time.day}/${chatController.lastMessae[chatController.compatibleUserList[index].user!.phoneNumber]!.time.month}/${chatController.lastMessae[chatController.compatibleUserList[index].user!.phoneNumber]!.time.year}',
                                  )
                                : Text(
                                    '${chatController.lastMessae[chatController.compatibleUserList[index].user!.phoneNumber]!.content} • ${chatController.lastMessae[chatController.compatibleUserList[index].user!.phoneNumber]!.time.day}/${chatController.lastMessae[chatController.compatibleUserList[index].user!.phoneNumber]!.time.month}/${chatController.lastMessae[chatController.compatibleUserList[index].user!.phoneNumber]!.time.year}',
                                  )
                            : Text(''),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
