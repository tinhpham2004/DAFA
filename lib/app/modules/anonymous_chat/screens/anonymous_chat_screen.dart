import 'dart:async';

import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/global_widgets/bottom_navigation.dart';
import 'package:dafa/app/modules/anonymous_chat/anonymous_chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/swipe/swipe_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/firebase_listener_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AnonymousChatScreen extends StatefulWidget {
  AnonymousChatScreen({super.key});

  @override
  State<AnonymousChatScreen> createState() => _AnonymousChatScreenState();
}

class _AnonymousChatScreenState extends State<AnonymousChatScreen> {
  final AnonymousChatController anonymousChatController =
      Get.find<AnonymousChatController>();

  final SignInController signInController = Get.find<SignInController>();

  final SwipeController swipeController = Get.find<SwipeController>();

  final DatabaseService databaseService = DatabaseService();

  final FirebaseListenerService firebaseListenerService =
      FirebaseListenerService();

  Timer? timer;
  Duration remainingTime = Duration(seconds: 60);

  Map<String, bool> visited = Map();
  List<List<String>> component = [];

  String compatibleUser = '';

  void resetDFS() {
    visited = Map();
    component = [];
    signInController.graphMatchUser.forEach((key, value) {
      visited[key] = false;
      component.add([]);
    });
  }

  void DFS(String user, int index) {
    visited[user] = true;
    component[index].add(user);
    signInController.graphMatchUser[user]!.forEach((element) {
      if (visited[element] == false) {
        DFS(element, index);
      }
    });
  }

  void FindCompatibleUser() {
    int index = 0;
    signInController.graphMatchUser.forEach((key, value) {
      if (visited[key] == false) {
        DFS(key, index);
        index++;
      }
    });

    for (int i = 0; i < component.length; i++) {
      if (component[i].contains(signInController.user.phoneNumber)) {
        for (int j = 0; j < component[i].length; j++) {
          if (component[i][j] == signInController.user.phoneNumber) {
            if (j % 2 == 1) {
              compatibleUser = component[i][j - 1];
            } else {
              if (j == component.length - 1) {
                compatibleUser = '';
              } else {
                compatibleUser = component[i][j + 1];
              }
            }
          }
        }
      }
    }
  }

  void searchMatchUser() {
    remainingTime = Duration(seconds: 60);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > Duration.zero) {
        setState(() {
          firebaseListenerService.LoadGraphMatchList();
          resetDFS();
          FindCompatibleUser();
          if (compatibleUser != '') {
            for (int i = 0; i < signInController.matchList.length; i++) {
              if (signInController.matchList[i].user != null &&
                  signInController.matchList[i].user!.phoneNumber ==
                      compatibleUser) {
                anonymousChatController.UpdateCurrIndex(i);
                Get.toNamed(AppRoutes.anonymous_message);
                timer.cancel();
                break;
              }
            }
          }
          remainingTime -= Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        signInController.user.isSearching = false;
        databaseService.UpdateUserData(signInController.user);
        anonymousChatController.UpdateIsSearching(false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    compatibleUser = '';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          bottomNavigationBar: BottomNavigation(onItem: 4),
          body: Container(
            decoration: BoxDecoration(gradient: AppColors.primaryColor),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    anonymousChatController.isSearching.value == false
                        ? 'Who will you match with today? Tap search to find out!'
                        : 'Searching for your perfect match! Buckle up, we\'ll connect you in under 60 seconds. Feeling impatient? Tap the X to cancel.',
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.cardTextStyle(AppColors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (anonymousChatController.isSearching.value == false) {
                        signInController.user.isSearching = true;
                        databaseService.UpdateUserData(signInController.user);
                        anonymousChatController.UpdateIsSearching(true);
                        searchMatchUser();
                      } else {
                        signInController.user.isSearching = false;
                        databaseService.UpdateUserData(signInController.user);
                        anonymousChatController.UpdateIsSearching(false);
                        timer!.cancel();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 400.h),
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.white, width: 3),
                          shape: BoxShape.circle),
                      child: Icon(
                        anonymousChatController.isSearching.value == false
                            ? Icons.search
                            : Icons.close_rounded,
                        color: AppColors.white,
                        size: 150.sp,
                      ),
                    ),
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
