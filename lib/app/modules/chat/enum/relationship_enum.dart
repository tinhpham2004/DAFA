import 'dart:developer';

import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum RelationshipEnum {
  empty,
  invitationSent, // Corresponds to case 1
  wantsToKnowYou, // Corresponds to case 2
  gettingToKnow, // Corresponds to case 3
  paused; // Corresponds to case 4

  // Function to map user relationship status to a message based on the relationship state
  String getRelationshipState(String userName) {
    switch (this) {
      case RelationshipEnum.invitationSent:
        return 'You sent an invitation to get to know. Let';
      case RelationshipEnum.wantsToKnowYou:
        return '$userName wants to get to know you';
      case RelationshipEnum.gettingToKnow:
        return 'Getting to know each other';
      case RelationshipEnum.paused:
        return 'Paused getting to know each other';
      case RelationshipEnum.empty:
        return '';
    }
  }

  Icon? getRelationshipIcon() {
    switch (this) {
      case RelationshipEnum.invitationSent:
        return const Icon(
          Icons.send_rounded,
          color: AppColors.send,
        );
      case RelationshipEnum.wantsToKnowYou:
        return const Icon(
          Icons.favorite_border_rounded,
          color: AppColors.pink,
        );
      case RelationshipEnum.gettingToKnow:
        return const Icon(
          Icons.favorite_rounded,
          color: AppColors.pink,
        );
      case RelationshipEnum.paused:
        return const Icon(
          Icons.heart_broken_rounded,
          color: AppColors.disabledBackground,
        );
      case RelationshipEnum.empty:
        return null;
    }
  }

  void onClick({
    required BuildContext context,
    required String userName,
    required String currentUserId,
    required String otherUserId,
    required VoidCallback onChangeData,
  }) {
    switch (this) {
      case RelationshipEnum.empty:
        final signInController = Get.find<SignInController>();
        int count = 0;
        signInController.getToKnowList?.forEach((key, value) {
          if (value == 1 || value == 3) {
            count++;
            log(key);
          }
        });
        if (signInController.getToKnowList != null && count >= 3) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // title: Text(
                //   '',
                //   style: CustomTextStyle.chatUserNameStyle(AppColors.black),
                //   textAlign: TextAlign.center,
                // ),
                content: const Text(
                  'You’ve connected with 3 people. Please get to know them before exploring more matches!',
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(
                      //       horizontal: 40.w,
                      //       vertical: 10.h,
                      //     ),
                      //     decoration: BoxDecoration(
                      //         color: AppColors.active,
                      //         borderRadius: BorderRadius.circular(40.sp)),
                      //     child: Text(
                      //       'Accept',
                      //       style: TextStyle(
                      //         color: AppColors.white,
                      //         fontSize: 32.sp,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ),
                      // ),
                      // Spacer(),
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(30.sp)),
                          child: Text(
                            'Close',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // title: Text(
                //   '',
                //   style: CustomTextStyle.chatUserNameStyle(AppColors.black),
                //   textAlign: TextAlign.center,
                // ),
                content: Text(
                  'Please be informed that DAFA currently limits the number of people you can get to know at the same time to 3. To connect with someone new, you must first send an invitation expressing your interest. Once both you and the other person accept the invitation, you will be able to communicate and get to know each other.\nDo you want to send an invitation?',
                  style: CustomTextStyle.h3(AppColors.black),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          onLeftButtonClick(
                            currentUser: currentUserId,
                            otherUser: otherUserId,
                            context: context,
                            onChangeData: onChangeData,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.active,
                              borderRadius: BorderRadius.circular(40.sp)),
                          child: Text(
                            'Send',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          onRightButtonClick(
                            currentUser: currentUserId,
                            otherUser: otherUserId,
                            context: context,
                            onChangeData: onChangeData,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(30.sp)),
                          child: Text(
                            'Close',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
        break;
      case RelationshipEnum.invitationSent:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text(
              //   '',
              //   style: CustomTextStyle.chatUserNameStyle(AppColors.black),
              //   textAlign: TextAlign.center,
              // ),
              content: Text(
                'You have sent an invitation to $userName. Please wait for their response or you can choose to remove the invitation.',
                style: CustomTextStyle.h3(AppColors.black),
                textAlign: TextAlign.center,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onLeftButtonClick(
                          currentUser: currentUserId,
                          otherUser: otherUserId,
                          context: context,
                          onChangeData: onChangeData,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.active,
                            borderRadius: BorderRadius.circular(40.sp)),
                        child: Text(
                          'Wait',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        onRightButtonClick(
                          currentUser: currentUserId,
                          otherUser: otherUserId,
                          context: context,
                          onChangeData: onChangeData,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(30.sp)),
                        child: Text(
                          'Remove',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
        break;
      case RelationshipEnum.wantsToKnowYou:
        final signInController = Get.find<SignInController>();
        int count = 0;
        signInController.getToKnowList?.forEach((key, value) {
          if (value == 1 || value == 3) {
            count++;
          }
        });
        if (signInController.getToKnowList != null && count >= 3) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // title: Text(
                //   '',
                //   style: CustomTextStyle.chatUserNameStyle(AppColors.black),
                //   textAlign: TextAlign.center,
                // ),
                content: const Text(
                  'You’ve connected with 3 people. Please get to know them before exploring more matches!',
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(
                      //       horizontal: 40.w,
                      //       vertical: 10.h,
                      //     ),
                      //     decoration: BoxDecoration(
                      //         color: AppColors.active,
                      //         borderRadius: BorderRadius.circular(40.sp)),
                      //     child: Text(
                      //       'Accept',
                      //       style: TextStyle(
                      //         color: AppColors.white,
                      //         fontSize: 32.sp,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ),
                      // ),
                      // Spacer(),
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(30.sp)),
                          child: Text(
                            'Close',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // title: Text(
                //   '',
                //   style: CustomTextStyle.chatUserNameStyle(AppColors.black),
                //   textAlign: TextAlign.center,
                // ),
                content: Text(
                  'You have received an invitation! Someone is interested in getting to know you. You can give them an opportunity by clicking \'Accept\' or you can remove the invitation.',
                  style: CustomTextStyle.h3(AppColors.black),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          onLeftButtonClick(
                            currentUser: currentUserId,
                            otherUser: otherUserId,
                            context: context,
                            onChangeData: onChangeData,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.active,
                              borderRadius: BorderRadius.circular(40.sp)),
                          child: Text(
                            'Accept',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          onRightButtonClick(
                            currentUser: currentUserId,
                            otherUser: otherUserId,
                            context: context,
                            onChangeData: onChangeData,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(30.sp)),
                          child: Text(
                            'Remove',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
        break;
      case RelationshipEnum.gettingToKnow:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text(
              //   '',
              //   style: CustomTextStyle.chatUserNameStyle(AppColors.black),
              //   textAlign: TextAlign.center,
              // ),
              content: Text(
                'You are currently getting to know him/her. Are you sure you want to break up? After this, you won\'t be able to communicate with each other anymore.',
                style: CustomTextStyle.h3(AppColors.black),
                textAlign: TextAlign.center,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onLeftButtonClick(
                          currentUser: currentUserId,
                          otherUser: otherUserId,
                          context: context,
                          onChangeData: onChangeData,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.active,
                            borderRadius: BorderRadius.circular(40.sp)),
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        onRightButtonClick(
                          currentUser: currentUserId,
                          otherUser: otherUserId,
                          context: context,
                          onChangeData: onChangeData,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(30.sp)),
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
        break;
      case RelationshipEnum.paused:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text(
              //   '',
              //   style: CustomTextStyle.chatUserNameStyle(AppColors.black),
              //   textAlign: TextAlign.center,
              // ),
              content: const Text(
                'You have chosen to end the relationship. You and the other person will no longer be able to communicate with each other from now on.',
                textAlign: TextAlign.center,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.symmetric(
                    //       horizontal: 40.w,
                    //       vertical: 10.h,
                    //     ),
                    //     decoration: BoxDecoration(
                    //         color: AppColors.active,
                    //         borderRadius: BorderRadius.circular(40.sp)),
                    //     child: Text(
                    //       'Accept',
                    //       style: TextStyle(
                    //         color: AppColors.white,
                    //         fontSize: 32.sp,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // ),
                    // Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(30.sp)),
                        child: Text(
                          'Close',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
        break;
    }
  }

  // Static method to convert an integer value to the corresponding RelationshipEnum
  static RelationshipEnum fromInt(int? value) {
    switch (value) {
      case 1:
        return RelationshipEnum.invitationSent;
      case 2:
        return RelationshipEnum.wantsToKnowYou;
      case 3:
        return RelationshipEnum.gettingToKnow;
      case 4:
        return RelationshipEnum.paused;
      default:
        throw Exception('Invalid relationship status value');
    }
  }

  void onLeftButtonClick({
    required BuildContext context,
    required String currentUser,
    required String otherUser,
    required VoidCallback onChangeData,
  }) {
    final databaseService = DatabaseService();
    final signInController = Get.find<SignInController>();
    final getToKnowList =
        Map<String, int>.from(signInController.getToKnowList ?? Map());
    switch (this) {
      case RelationshipEnum.empty:
        getToKnowList[otherUser] = 1;
        // getToKnowList[currentUser] = 2;
        signInController.getToKnowList = getToKnowList;

        databaseService.updateGetToKnow(
            documentId: currentUser, key: otherUser, value: 1);
        databaseService.updateGetToKnow(
            documentId: otherUser, key: currentUser, value: 2);
        onChangeData();
        Navigator.pop(context);
        return;
      case RelationshipEnum.invitationSent:
        onChangeData();

        Navigator.pop(context);

        return;
      case RelationshipEnum.wantsToKnowYou:
        getToKnowList[otherUser] = 3;
        // getToKnowList[currentUser] = 3;
        signInController.getToKnowList = getToKnowList;

        databaseService.updateGetToKnow(
            documentId: currentUser, key: otherUser, value: 3);
        databaseService.updateGetToKnow(
            documentId: otherUser, key: currentUser, value: 3);
        onChangeData();

        Navigator.pop(context);

        return;
      case RelationshipEnum.gettingToKnow:
        onChangeData();
        Navigator.pop(context);

        return;
      case RelationshipEnum.paused:
        onChangeData();

        Navigator.pop(context);

        return;
    }
  }

  void onRightButtonClick({
    required BuildContext context,
    required String currentUser,
    required String otherUser,
    required VoidCallback onChangeData,
  }) {
    final databaseService = DatabaseService();
    final signInController = Get.find<SignInController>();

    final getToKnowList =
        Map<String, int>.from(signInController.getToKnowList ?? Map());

    switch (this) {
      case RelationshipEnum.empty:
        onChangeData();

        Navigator.pop(context);

        return;
      case RelationshipEnum.invitationSent:
        getToKnowList.remove(otherUser);
        // getToKnowList.remove(currentUser);
        signInController.getToKnowList = getToKnowList;

        databaseService.removeGetToKnow(
            documentId: currentUser, key: otherUser);
        databaseService.removeGetToKnow(
            documentId: otherUser, key: currentUser);
        onChangeData();

        Navigator.pop(context);

        return;
      case RelationshipEnum.wantsToKnowYou:
        getToKnowList.remove(otherUser);
        // getToKnowList.remove(currentUser);
        signInController.getToKnowList = getToKnowList;

        databaseService.removeGetToKnow(
            documentId: currentUser, key: otherUser);
        databaseService.removeGetToKnow(
            documentId: otherUser, key: currentUser);
        onChangeData();

        Navigator.pop(context);

        return;
      case RelationshipEnum.gettingToKnow:
        getToKnowList[otherUser] = 4;
        // getToKnowList[currentUser] = 4;
        signInController.getToKnowList = getToKnowList;

        databaseService.updateGetToKnow(
            documentId: currentUser, key: otherUser, value: 4);
        databaseService.updateGetToKnow(
            documentId: otherUser, key: currentUser, value: 4);
        onChangeData();

        Navigator.pop(context);

        return;
      case RelationshipEnum.paused:
        onChangeData();
        Navigator.pop(context);

        return;
    }
  }
}
