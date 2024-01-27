import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/models/message.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/chat/widgets/add_message_field.dart';
import 'package:dafa/app/modules/chat/widgets/report.dart';
import 'package:dafa/app/modules/chat/widgets/send_message_button.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});
  final ChatController chatController = Get.find<ChatController>();
  final SignInController signInController = Get.find<SignInController>();
  DatabaseService databaseService = DatabaseService();
  Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('time')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    chatController.UpdateIsFirstTimeScroll(true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 2,
          title: ListTile(
            leading: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.view_profile);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(chatController
                    .compatibleUserList[chatController.currIndex.value]
                    .user!
                    .images
                    .first),
              ),
            ),
            title: Text(
              chatController.compatibleUserList[chatController.currIndex.value]
                  .user!.name,
              style: CustomTextStyle.profileHeader(AppColors.black),
            ),
            trailing: Report(chatController: chatController),
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
                    controller: chatController.scrollController,
                    itemCount:
                        snapshot.data != null ? snapshot.data!.docs.length : 0,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      if (index == 0 &&
                          chatController.isFirstTimeScroll == true) {
                        chatController.scrollController
                            .jumpTo(1000.h * snapshot.data!.docs.length);
                        chatController.UpdateIsFirstTimeScroll(false);
                      }
                      QueryDocumentSnapshot message =
                          snapshot.data!.docs[index];
                      Timestamp time = message['time'];
                      String content = message['content'];
                      DateTime date = time.toDate();
                      String sender = message['sender'];
                      String receiver = message['receiver'];
                      if (chatController
                                  .compatibleUserList[
                                      chatController.currIndex.value]
                                  .user!
                                  .phoneNumber ==
                              sender ||
                          chatController
                                  .compatibleUserList[
                                      chatController.currIndex.value]
                                  .user!
                                  .phoneNumber ==
                              receiver) {
                        chatController.lastMessae[
                            chatController
                                .compatibleUserList[
                                    chatController.currIndex.value]
                                .user!
                                .phoneNumber] = Message(
                            sender: sender,
                            receiver: receiver,
                            content: content,
                            time: date);
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
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              date.hour.toString() +
                                  ':' +
                                  date.minute.toString(),
                              textAlign: TextAlign.end,
                            ),
                          );
                        } else {
                          if (chatController.reportMessages.contains(content) ==
                              false) chatController.reportMessages.add(content);
                          return ListTile(
                            leading: Container(
                              height: 80.h,
                              width: 80.w,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  chatController
                                      .compatibleUserList[
                                          chatController.currIndex.value]
                                      .user!
                                      .images
                                      .first,
                                ),
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
                              date.hour.toString() +
                                  ':' +
                                  date.minute.toString(),
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
                        child: AddMessageField(chatController: chatController),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 10.w, right: 20.w, bottom: 40.h),
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
