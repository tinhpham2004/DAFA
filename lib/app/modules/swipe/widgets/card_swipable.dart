import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/swipe/swipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardSwipable extends StatelessWidget {
  CardSwipable({
    super.key,
    required this.signInController,
    required this.swipeController,
  });

  final SignInController signInController;
  final SwipeController swipeController;

  @override
  Widget build(BuildContext context) {
    return CardSwiper(
      controller: swipeController.cardSwiperController,
      isLoop: false,
      allowedSwipeDirection:
          AllowedSwipeDirection.only(left: true, right: true),
      cardsCount: signInController.matchList.length,
      padding: EdgeInsetsDirectional.zero,
      cardBuilder: (context, index, horizontalOffsetPercentage,
          verticalOffsetPercentage) {
        return Container(
          color: AppColors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  signInController.matchList[index].user.images[0],
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          signInController.matchList[index].user.name +
                              ', ' +
                              (DateTime.now().year -
                                      int.parse(signInController
                                          .matchList[index].user.dateOfBirth
                                          .substring(6)))
                                  .toString(),
                          style: CustomTextStyle.profileHeader(AppColors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          signInController.matchList[index].user.bio,
                          style: CustomTextStyle.cardTextStyle(
                              AppColors.secondaryColor),
                        ),
                      ),

                      //
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Wrap(
                          children: [
                            Icon(Icons.home_outlined),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              child: Text(
                                signInController.matchList[index].user.address,
                                style: CustomTextStyle.cardTextStyle(
                                  AppColors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      //
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Wrap(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              child: Text(
                                (signInController.matchList[index].distance
                                            .round())
                                        .toString() +
                                    'km away',
                                style: CustomTextStyle.cardTextStyle(
                                  AppColors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      //
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Wrap(
                          children: [
                            Icon(Icons.favorite_outline_sharp),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              child: Text(
                                (signInController.matchList[index].user.hobby),
                                style: CustomTextStyle.cardTextStyle(
                                  AppColors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      //
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Wrap(
                          children: [
                            Icon(Icons.straighten_rounded),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              child: Text(
                                signInController.matchList[index].user.height,
                                style: CustomTextStyle.cardTextStyle(
                                  AppColors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      //
                      Container(
                        width: 700.w,
                        height: 900.h,
                        margin: EdgeInsets.only(top: 20.h),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Image.network(
                            signInController.matchList[index].user.images[1],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //
                      Container(
                        width: 700.w,
                        height: 900.h,
                        margin: EdgeInsets.only(top: 20.h),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Image.network(
                            signInController.matchList[index].user.images[2],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //
                      signInController.matchList[index].user.images.length > 3
                          ? Container(
                              width: 700.w,
                              height: 900.h,
                              margin: EdgeInsets.only(top: 20.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.network(
                                  signInController
                                      .matchList[index].user.images[3],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(),

                      //
                      signInController.matchList[index].user.images.length > 4
                          ? Container(
                              width: 700.w,
                              height: 900.h,
                              margin: EdgeInsets.only(top: 20.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.network(
                                  signInController
                                      .matchList[index].user.images[4],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(),

                      //
                      signInController.matchList[index].user.images.length > 5
                          ? Container(
                              width: 700.w,
                              height: 900.h,
                              margin: EdgeInsets.only(top: 20.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.network(
                                  signInController
                                      .matchList[index].user.images[5],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
