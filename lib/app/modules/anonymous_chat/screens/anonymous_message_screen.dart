import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/anonymous_chat/anonymous_chat_controller.dart';
import 'package:dafa/app/modules/anonymous_chat/widgets/add_message_field.dart';
import 'package:dafa/app/modules/anonymous_chat/widgets/like.dart';
import 'package:dafa/app/modules/anonymous_chat/widgets/report.dart';
import 'package:dafa/app/modules/anonymous_chat/widgets/send_message_button.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/firebase_listener_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AnonymouseMessageScreen extends StatefulWidget {
  const AnonymouseMessageScreen({super.key});

  @override
  State<AnonymouseMessageScreen> createState() =>
      _AnonymouseMessageScreenState();
}

class _AnonymouseMessageScreenState extends State<AnonymouseMessageScreen> {
  final AnonymousChatController anonymousChatController =
      Get.find<AnonymousChatController>();

  final SignInController signInController = Get.find<SignInController>();

  final FirebaseListenerService firebaseListenerService =
      FirebaseListenerService();

  final DatabaseService databaseService = DatabaseService();

  final ChatController chatController = Get.find<ChatController>();

  Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('time', descending: true)
      .snapshots();

  Duration remainingTime = Duration(seconds: 180);
  Timer? timer;

  @override
  void initState() {
    super.initState();
    anonymousChatController.UpdateIsFirstTimeScroll(true);
    anonymousChatController.UpdateIsMatch(false);
    anonymousChatController.UpdateIsFirstTimeLike(true);
    firebaseListenerService.LoadCompatibleList();
    _startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (remainingTime > Duration.zero) {
          setState(() {
            remainingTime -= Duration(seconds: 1);
            if (anonymousChatController.isMatch == false &&
                signInController.compatibleList.contains(signInController
                        .matchList[anonymousChatController.currIndex.value]
                        .user!
                        .phoneNumber) ==
                    true) {
              int index = 0;
              if (chatController.compatibleUserList.length <
                  signInController.compatibleList.length) {
                for (int i = 0;
                    i < signInController.matchListForChat.length;
                    i++) {
                  for (int j = 0;
                      j < signInController.compatibleList.length;
                      j++) {
                    if (signInController
                                .matchListForChat[i].user!.phoneNumber ==
                            signInController.compatibleList[j] &&
                        chatController.compatibleUserList.contains(
                                signInController.matchListForChat[i]) ==
                            false) {
                      chatController.compatibleUserList
                          .add(signInController.matchListForChat[i]);
                      if (signInController.compatibleList[j] ==
                          signInController
                              .matchList[
                                  anonymousChatController.currIndex.value]
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
            }
            if (anonymousChatController.isMatch) timer.cancel();
          });
        } else {
          if (signInController.dislikeList.contains(signInController
                  .matchList[anonymousChatController.currIndex.value]
                  .user!
                  .phoneNumber) ==
              false) {
            signInController.dislikeList.add(signInController
                .matchList[anonymousChatController.currIndex.value]
                .user!
                .phoneNumber);
            databaseService.UpdateMatchedList();
          }
          anonymousChatController.UpdateIsSearching(false);
          signInController.user.isSearching = false;
          databaseService.UpdateUserData(signInController.user);
          Get.toNamed(AppRoutes.anonymous_chat);
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        onPopInvoked: (didPop) {
          if (signInController.dislikeList.contains(signInController
                  .matchList[anonymousChatController.currIndex.value]
                  .user!
                  .phoneNumber) ==
              false) {
            signInController.dislikeList.add(signInController
                .matchList[anonymousChatController.currIndex.value]
                .user!
                .phoneNumber);
            databaseService.UpdateMatchedList();
          }
          anonymousChatController.UpdateIsSearching(false);
          signInController.user.isSearching = false;
          databaseService.UpdateUserData(signInController.user);
          timer?.cancel();
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            flexibleSpace: Container(color: AppColors.backgroundColor),
            titleSpacing: 2,
            leading: GestureDetector(
              onTap: () {
                if (signInController.dislikeList.contains(signInController
                        .matchList[anonymousChatController.currIndex.value]
                        .user!
                        .phoneNumber) ==
                    false) {
                  signInController.dislikeList.add(signInController
                      .matchList[anonymousChatController.currIndex.value]
                      .user!
                      .phoneNumber);
                  databaseService.UpdateMatchedList();
                }
                anonymousChatController.UpdateIsSearching(false);
                signInController.user.isSearching = false;
                databaseService.UpdateUserData(signInController.user);
                Get.back();
                timer?.cancel();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.white,
              ),
            ),
            title: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    ExactAssetImage('assets/images/anonymous_avatar.jpg'),
              ),
              title: Text(
                signInController
                    .matchList[anonymousChatController.currIndex.value]
                    .user!
                    .name,
                style: CustomTextStyle.profileHeader(AppColors.white),
              ),
              subtitle: remainingTime.inSeconds % 60 < 10
                  ? Text(
                      '0${remainingTime.inMinutes.toString()} : 0${(remainingTime.inSeconds % 60).toString()}')
                  : Text(
                      '0${remainingTime.inMinutes.toString()} : ${(remainingTime.inSeconds % 60).toString()}'),
              trailing:
                  Report(anonymousChatController: anonymousChatController),
            ),
          ),
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 200.h),
                child: StreamBuilder(
                  stream: messageStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                        'Something went wrong',
                        style: CustomTextStyle.error_text_style(),
                      );
                    }
                    return ListView.builder(
                      reverse: true,
                      controller: anonymousChatController.scrollController,
                      itemCount: snapshot.data != null
                          ? snapshot.data!.docs.length
                          : 0,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        QueryDocumentSnapshot message =
                            snapshot.data!.docs[index];
                        Timestamp time = message['time'];
                        String content = message['content'];
                        DateTime date = time.toDate();
                        String sender = message['sender'];
                        String receiver = message['receiver'];
                        if ((signInController
                                        .matchList[anonymousChatController
                                            .currIndex.value]
                                        .user!
                                        .phoneNumber ==
                                    sender &&
                                signInController.user.phoneNumber ==
                                    receiver) ||
                            (signInController
                                        .matchList[anonymousChatController
                                            .currIndex.value]
                                        .user!
                                        .phoneNumber ==
                                    receiver &&
                                signInController.user.phoneNumber == sender)) {
                          if (signInController.user.phoneNumber == sender) {
                            return ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 150.w),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                      horizontal: 8.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.send,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.r),
                                        topRight: Radius.circular(30.r),
                                        bottomLeft: Radius.circular(20.r),
                                      ),
                                    ),
                                    child: Text(
                                      content,
                                      style: CustomTextStyle.messageStyle(
                                          AppColors.white),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                date.hour.toString() +
                                    ':' +
                                    date.minute.toString(),
                                textAlign: TextAlign.end,
                              ),
                            );
                          } else if (signInController
                                  .matchList[
                                      anonymousChatController.currIndex.value]
                                  .user!
                                  .phoneNumber ==
                              sender) {
                            if (anonymousChatController.reportMessages
                                    .contains(content) ==
                                false)
                              anonymousChatController.reportMessages
                                  .add(content);
                            return ListTile(
                              leading: Container(
                                height: 80.h,
                                width: 80.w,
                                child: CircleAvatar(
                                  backgroundImage: ExactAssetImage(
                                      'assets/images/anonymous_avatar.jpg'),
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 150.w),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                      horizontal: 8.w,
                                    ),
                                    child: Text(
                                      content,
                                      style: CustomTextStyle.messageStyle(
                                          AppColors.white),
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.receive,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.r),
                                        topRight: Radius.circular(30.r),
                                        bottomRight: Radius.circular(20.r),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                date.hour.toString() +
                                    ':' +
                                    date.minute.toString(),
                                textAlign: TextAlign.start,
                              ),
                            );
                          }
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 20.w,
                            bottom: 40.h,
                          ),
                          child: AddMessageField(
                            anonymousChatController: anonymousChatController,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.transparent,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 10.w, right: 10.w, bottom: 40.h),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: SendMessageButton(),
                      ),
                      LikeButton(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
