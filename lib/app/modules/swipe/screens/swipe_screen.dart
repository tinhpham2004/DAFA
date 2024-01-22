import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/global_widgets/bottom_navigation.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/swipe/swipe_controller.dart';
import 'package:dafa/app/modules/swipe/widgets/card_swipable.dart';
import 'package:dafa/app/modules/swipe/widgets/dislike_button.dart';
import 'package:dafa/app/modules/swipe/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SwipeScreen extends StatelessWidget {
  SwipeScreen({super.key});

  final SignInController signInController = Get.find<SignInController>();
  final SwipeController swipeController = Get.find<SwipeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigation(onItem: 1),
        body: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CardSwipable(
                signInController: signInController,
                swipeController: swipeController,
              ),
              Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      DislikeButton(
                        swipeController: swipeController,
                      ),
                      GestureDetector(
                        onTap: () {
                          swipeController.cardSwiperController.undo();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 1150.h, right: 100.w),
                          height: 200.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.primaryColor,
                          ),
                          child: Icon(
                            Icons.replay_rounded,
                            color: AppColors.white,
                            size: 70.sp,
                          ),
                        ),
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
    );
  }
}
