import 'package:cached_network_image/cached_network_image.dart';
import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/models/match_user.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/swipe/swipe_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardSwipable extends StatelessWidget {
  CardSwipable({
    super.key,
  });

  final SignInController signInController = Get.find<SignInController>();
  final SwipeController swipeController = Get.find<SwipeController>();
  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CardSwiper(
        numberOfCardsDisplayed: signInController.matchList.length > 1 ? 2 : 1,
        initialIndex: swipeController.curIndex.value,
        onSwipe: (previousIndex, currentIndex, direction) async {
          if (swipeController.swipeState.value == 'left') {
            signInController.dislikeList.add(signInController
                .matchList[swipeController.curIndex.value].user!.phoneNumber);
            databaseService.UpdateMatchedList();
          } else if (swipeController.swipeState.value == 'right') {
            signInController.likeList.add(signInController
                .matchList[swipeController.curIndex.value].user!.phoneNumber);
            if (await databaseService.CheckIsLike(signInController
                .matchList[swipeController.curIndex.value].user!.phoneNumber)) {
              signInController.compatibleList.add(signInController
                  .matchList[swipeController.curIndex.value].user!.phoneNumber);
              databaseService.UpdateCompatibleList(signInController
                  .matchList[swipeController.curIndex.value].user!.phoneNumber);
              await showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 300.h,
                            child: AppIcons.logo,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 40.h),
                            child: Text(
                              'Double tap magic! You and ${signInController.matchList[swipeController.curIndex.value].user!.name} are a match. Say hi and see where things go!✨',
                              style: CustomTextStyle.cardTextStyle(
                                AppColors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            databaseService.UpdateMatchedList();
          }
          swipeController.UpdateCurIndex(currentIndex!);
          return true;
        },
        onSwipeDirectionChange: (horizontalDirection, verticalDirection) {
          if (horizontalDirection == CardSwiperDirection.left) {
            swipeController.UpdateSwipeState('left');
          } else if (horizontalDirection == CardSwiperDirection.right) {
            swipeController.UpdateSwipeState('right');
          } else {
            swipeController.UpdateSwipeState('');
          }
        },
        controller: swipeController.cardSwiperController,
        isLoop: false,
        isDisabled: (swipeController.curIndex.value ==
            signInController.matchList.length - 1),
        allowedSwipeDirection:
            AllowedSwipeDirection.only(left: true, right: true),
        cardsCount: signInController.matchList.length,
        padding: EdgeInsetsDirectional.zero,
        cardBuilder: (context, index, horizontalOffsetPercentage,
            verticalOffsetPercentage) {
          if (signInController.matchList[index].user != null) {
            return Stack(
              children: [
                Container(
                  color: AppColors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        signInController.matchList[index].user!.images.length >
                                0
                            // ? Image.network(
                            //     signInController
                            //         .matchList[index].user!.images[0],
                            //     fit: BoxFit.cover,
                            //   )
                            ? CachedNetworkImage(
                                imageUrl: signInController
                                    .matchList[index].user!.images[0],
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    height: 1075.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  );
                                },
                                placeholder: (context, url) {
                                  return CircularProgressIndicator();
                                },
                              )
                            : Container(),
                        Container(
                          margin: EdgeInsets.only(left: 25.w, right: 25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20.h),
                                child: Text(
                                  signInController.matchList[index].user!.name +
                                      ', ' +
                                      (DateTime.now().year -
                                              int.parse(signInController
                                                  .matchList[index]
                                                  .user!
                                                  .dateOfBirth
                                                  .substring(6)))
                                          .toString(),
                                  style: CustomTextStyle.profileHeader(
                                      AppColors.black),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20.h),
                                child: Text(
                                  signInController.matchList[index].user!.bio,
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
                                        signInController
                                            .matchList[index].user!.address,
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
                                        (signInController
                                                    .matchList[index].distance
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
                              signInController.matchList[index].user!.hobby !=
                                      ''
                                  ? Container(
                                      margin: EdgeInsets.only(top: 10.h),
                                      child: Wrap(
                                        children: [
                                          Icon(Icons.favorite_outline_sharp),
                                          Container(
                                            margin: EdgeInsets.only(left: 10.w),
                                            child: Text(
                                              (signInController.matchList[index]
                                                  .user!.hobby),
                                              style:
                                                  CustomTextStyle.cardTextStyle(
                                                AppColors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),

                              //
                              signInController.matchList[index].user!.height !=
                                      ''
                                  ? Container(
                                      margin: EdgeInsets.only(top: 10.h),
                                      child: Wrap(
                                        children: [
                                          Icon(Icons.straighten_rounded),
                                          Container(
                                            margin: EdgeInsets.only(left: 10.w),
                                            child: Text(
                                              signInController.matchList[index]
                                                  .user!.height,
                                              style:
                                                  CustomTextStyle.cardTextStyle(
                                                AppColors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),

                              //
                              signInController.matchList[index].user!.images
                                          .length >
                                      1
                                  ? Container(
                                      width: 700.w,
                                      height: 900.h,
                                      margin: EdgeInsets.only(top: 20.h),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        child: CachedNetworkImage(
                                          imageUrl: signInController
                                              .matchList[index].user!.images[1],
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover)),
                                            );
                                          },
                                          placeholder: (context, url) {
                                            return CircularProgressIndicator();
                                          },
                                        ),
                                      ),
                                    )
                                  : Container(),

                              //
                              signInController.matchList[index].user!.images
                                          .length >
                                      2
                                  ? Container(
                                      width: 700.w,
                                      height: 900.h,
                                      margin: EdgeInsets.only(top: 20.h),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        child: CachedNetworkImage(
                                          imageUrl: signInController
                                              .matchList[index].user!.images[2],
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover)),
                                            );
                                          },
                                          placeholder: (context, url) {
                                            return CircularProgressIndicator();
                                          },
                                        ),
                                      ),
                                    )
                                  : Container(),

                              //
                              signInController.matchList[index].user!.images
                                          .length >
                                      3
                                  ? Container(
                                      width: 700.w,
                                      height: 900.h,
                                      margin: EdgeInsets.only(top: 20.h),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        child: CachedNetworkImage(
                                          imageUrl: signInController
                                              .matchList[index].user!.images[3],
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover)),
                                            );
                                          },
                                          placeholder: (context, url) {
                                            return CircularProgressIndicator();
                                          },
                                        ),
                                      ),
                                    )
                                  : Container(),

                              //
                              signInController.matchList[index].user!.images
                                          .length >
                                      4
                                  ? Container(
                                      width: 700.w,
                                      height: 900.h,
                                      margin: EdgeInsets.only(top: 20.h),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        child: CachedNetworkImage(
                                          imageUrl: signInController
                                              .matchList[index].user!.images[4],
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover)),
                                            );
                                          },
                                          placeholder: (context, url) {
                                            return CircularProgressIndicator();
                                          },
                                        ),
                                      ),
                                    )
                                  : Container(),

                              //
                              signInController.matchList[index].user!.images
                                          .length >
                                      5
                                  ? Container(
                                      width: 700.w,
                                      height: 900.h,
                                      margin: EdgeInsets.only(
                                          top: 20.h, bottom: 30.h),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        child: CachedNetworkImage(
                                          imageUrl: signInController
                                              .matchList[index].user!.images[5],
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover)),
                                            );
                                          },
                                          placeholder: (context, url) {
                                            return CircularProgressIndicator();
                                          },
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
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Obx(
                      () => swipeController.swipeState.value == 'right' &&
                              swipeController.curIndex.value == index
                          ? Container(
                              margin: EdgeInsets.only(right: 500.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                ),
                                border: Border.all(
                                  color: AppColors.pink,
                                  width: 4,
                                ),
                              ),
                              child: Text(
                                'LIKE',
                                style: CustomTextStyle.h1(
                                  AppColors.pink,
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Obx(
                      () => swipeController.swipeState.value == 'left' &&
                              swipeController.curIndex.value == index
                          ? Container(
                              margin: EdgeInsets.only(left: 300.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                ),
                                border: Border.all(
                                  color: AppColors.red,
                                  width: 4,
                                ),
                              ),
                              child: Text(
                                'DISLIKE',
                                style: CustomTextStyle.h1(
                                  AppColors.red,
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Container(
              child: Column(
                children: [
                  AppIcons.logo,
                  Text(
                    'Love guru alert! You\'ve seen everyone! Take a breather, recharge your love radar, and new singles will appear like magic ✨.',
                    style: CustomTextStyle.h2(AppColors.backgroundColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
