import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/global_widgets/bottom_navigation.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/swipe/swipe_controller.dart';
import 'package:dafa/app/modules/swipe/widgets/card_swipable.dart';
import 'package:dafa/app/modules/swipe/widgets/like.dart';
import 'package:dafa/app/modules/swipe/widgets/dislike_button.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SwipeScreen extends StatefulWidget {
  SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> with WidgetsBindingObserver {
  final SignInController signInController = Get.find<SignInController>();

  final SwipeController swipeController = Get.find<SwipeController>();

  final DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        signInController.user.isOnline = true;
        databaseService.UpdateUserData(signInController.user);
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        signInController.user.isOnline = false;
        databaseService.UpdateUserData(signInController.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          bottomNavigationBar: BottomNavigation(onItem: 2),
          body: Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CardSwipable(),
                Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        DislikeButton(
                          swipeController: swipeController,
                        ),
                        LikeButton(
                          swipeController: swipeController,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
