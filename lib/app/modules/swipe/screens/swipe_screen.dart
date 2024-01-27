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
    );
  }
}
