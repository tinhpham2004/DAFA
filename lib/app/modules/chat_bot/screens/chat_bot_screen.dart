import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/chat_bot/widgets/add_message_field.dart';
import 'package:dafa/app/modules/chat_bot/widgets/send_message_button.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatBotScreen extends StatelessWidget {
  ChatBotScreen({super.key});

  final SignInController signInController = Get.find<SignInController>();

  Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('time', descending: true)
      .snapshots();

  String TimeFormat(String time) {
    if (time.length < 2) time = '0' + time;
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 2,
          leading: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.swipe);
            },
            child: Icon(Icons.arrow_back_ios_new),
          ),
          title: ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  ExactAssetImage('assets/images/chat_bot_avatar.jpg'),
            ),
            title: Text(
              'Cupid',
              style: CustomTextStyle.profileHeader(AppColors.black),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 200.h),
              child: StreamBuilder(
                stream: messageStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      'Something went wrong',
                      style: CustomTextStyle.error_text_style(),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount:
                        snapshot.data != null ? snapshot.data!.docs.length : 0,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      QueryDocumentSnapshot message =
                          snapshot.data!.docs[index];
                      Timestamp time = message['time'];
                      String content = message['content'];
                      DateTime date = time.toDate();
                      String sender = message['sender'];
                      String receiver = message['receiver'];
                      String category = message['category'];
                      if ((signInController.user.phoneNumber == sender &&
                              'chat_bot' == receiver) ||
                          (signInController.user.phoneNumber == receiver &&
                              'chat_bot' == sender)) {
                        if (signInController.user.phoneNumber == sender) {
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 150.w),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8.h,
                                    horizontal: 8.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.send,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(30.r),
                                      bottomLeft: Radius.circular(20.r),
                                    ),
                                  ),
                                  child: Text(
                                    content,
                                    style: CustomTextStyle.messageStyle(
                                        AppColors.white),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              TimeFormat(date.hour.toString()) +
                                  ':' +
                                  TimeFormat(date.minute.toString()),
                              textAlign: TextAlign.end,
                            ),
                          );
                        } else if ('chat_bot' == sender) {
                          return ListTile(
                            leading: Container(
                              height: 80.h,
                              width: 80.w,
                              child: CircleAvatar(
                                backgroundImage: ExactAssetImage(
                                    'assets/images/chat_bot_avatar.jpg'),
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 150.w),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8.h,
                                    horizontal: 8.w,
                                  ),
                                  child: Text(
                                    content,
                                    style: CustomTextStyle.messageStyle(
                                        AppColors.black),
                                    textAlign: TextAlign.start,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.receive,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(30.r),
                                      bottomRight: Radius.circular(20.r),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              TimeFormat(date.hour.toString()) +
                                  ':' +
                                  TimeFormat(date.minute.toString()),
                              textAlign: TextAlign.start,
                            ),
                          );
                        }
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 20.w,
                          bottom: 40.h,
                        ),
                        child: AddMessageField(),
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 10.w, right: 10.w, bottom: 40.h),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: SendMessageButton(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
