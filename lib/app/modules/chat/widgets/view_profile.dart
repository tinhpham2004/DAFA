import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewProfile extends StatelessWidget {
  ViewProfile({super.key});
  final SignInController signInController = Get.find<SignInController>();
  final ChatController chatController = Get.find<ChatController>();
  final DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    double distance = databaseService.calculateDistance(
        signInController.user.coordinate.latitude,
        signInController.user.coordinate.longitude,
        chatController.compatibleUserList[chatController.currIndex.value].user!
            .coordinate.latitude,
        chatController.compatibleUserList[chatController.currIndex.value].user!
            .coordinate.longitude);
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chatController
                            .compatibleUserList[chatController.currIndex.value]
                            .user!
                            .images
                            .length >
                        0
                    ? Image.network(
                        chatController
                            .compatibleUserList[chatController.currIndex.value]
                            .user!
                            .images
                            .first,
                        fit: BoxFit.cover,
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
                          chatController
                                  .compatibleUserList[
                                      chatController.currIndex.value]
                                  .user!
                                  .name +
                              ', ' +
                              (DateTime.now().year -
                                      int.parse(chatController
                                          .compatibleUserList[
                                              chatController.currIndex.value]
                                          .user!
                                          .dateOfBirth
                                          .substring(6)))
                                  .toString(),
                          style: CustomTextStyle.profileHeader(AppColors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Text(
                          chatController
                              .compatibleUserList[
                                  chatController.currIndex.value]
                              .user!
                              .bio,
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
                                chatController
                                    .compatibleUserList[
                                        chatController.currIndex.value]
                                    .user!
                                    .address,
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
                                (distance.round()).toString() + 'km away',
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
                                (chatController
                                    .compatibleUserList[
                                        chatController.currIndex.value]
                                    .user!
                                    .hobby),
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
                                chatController
                                    .compatibleUserList[
                                        chatController.currIndex.value]
                                    .user!
                                    .height,
                                style: CustomTextStyle.cardTextStyle(
                                  AppColors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      //
                      chatController
                                  .compatibleUserList[
                                      chatController.currIndex.value]
                                  .user!
                                  .images
                                  .length >
                              1
                          ? Container(
                              width: 700.w,
                              height: 900.h,
                              margin: EdgeInsets.only(top: 20.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.network(
                                  chatController
                                      .compatibleUserList[
                                          chatController.currIndex.value]
                                      .user!
                                      .images[1],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(),

                      //
                      chatController
                                  .compatibleUserList[
                                      chatController.currIndex.value]
                                  .user!
                                  .images
                                  .length >
                              2
                          ? Container(
                              width: 700.w,
                              height: 900.h,
                              margin: EdgeInsets.only(top: 20.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.network(
                                  chatController
                                      .compatibleUserList[
                                          chatController.currIndex.value]
                                      .user!
                                      .images[2],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(),

                      //
                      chatController
                                  .compatibleUserList[
                                      chatController.currIndex.value]
                                  .user!
                                  .images
                                  .length >
                              3
                          ? Container(
                              width: 700.w,
                              height: 900.h,
                              margin: EdgeInsets.only(top: 20.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.network(
                                  chatController
                                      .compatibleUserList[
                                          chatController.currIndex.value]
                                      .user!
                                      .images[3],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(),

                      //
                      chatController
                                  .compatibleUserList[
                                      chatController.currIndex.value]
                                  .user!
                                  .images
                                  .length >
                              4
                          ? Container(
                              width: 700.w,
                              height: 900.h,
                              margin: EdgeInsets.only(top: 20.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.network(
                                  chatController
                                      .compatibleUserList[
                                          chatController.currIndex.value]
                                      .user!
                                      .images[4],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(),

                      //
                      chatController
                                  .compatibleUserList[
                                      chatController.currIndex.value]
                                  .user!
                                  .images
                                  .length >
                              5
                          ? Container(
                              width: 700.w,
                              height: 900.h,
                              margin: EdgeInsets.only(top: 20.h, bottom: 30.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.network(
                                  chatController
                                      .compatibleUserList[
                                          chatController.currIndex.value]
                                      .user!
                                      .images[5],
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
        ),
      ),
    );
  }
}
