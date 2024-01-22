import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/swipe/swipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DislikeButton extends StatelessWidget {
  const DislikeButton({
    super.key,
    required this.swipeController,
  });
  final SwipeController swipeController;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        swipeController.cardSwiperController.swipeLeft();
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 100.w,
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
