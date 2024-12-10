import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/suggest_friend/suggest_friend_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LikeButton extends StatelessWidget {
  LikeButton({
    super.key,
    required this.suggestFriendController,
  });
  final SuggestFriendController suggestFriendController;
  final SignInController signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (suggestFriendController.curIndex.value !=
            signInController.matchList.length - 1) {
          suggestFriendController.cardSwiperController.swipe(CardSwiperDirection.right);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 1150.h),
        height: 200.h,
        width: 150.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.pink,
        ),
        child: Icon(
          Icons.favorite,
          color: AppColors.white,
          size: 70.sp,
        ),
      ),
    );
  }
}
