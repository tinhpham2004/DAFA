import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/swipe/swipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DislikeButton extends StatelessWidget {
  DislikeButton({
    super.key,
    required this.swipeController,
  });
  final SwipeController swipeController;
  final SignInController signInController = Get.find<SignInController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (swipeController.curIndex.value !=
            signInController.matchList.length - 1) {
          swipeController.cardSwiperController.swipe(CardSwiperDirection.left);
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 250.w,
          top: 1150.h,
        ),
        height: 200.h,
        width: 150.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.red,
        ),
        child: Icon(
          Icons.close_rounded,
          color: AppColors.white,
          size: 70.sp,
        ),
      ),
    );
  }
}
