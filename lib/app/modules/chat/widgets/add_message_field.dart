import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/services/openAI_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddMessageField extends StatelessWidget {
  AddMessageField({
    super.key,
    required this.chatController,
  });

  final ChatController chatController;
  final openAIService = OpenAIService();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: chatController.messageController,
      focusNode: _focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 0, bottom: 10.sp, left: 25.sp),
        suffix: Obx(
          () => chatController.isFocus.value
              ? GestureDetector(
                  onTap: () async {
                    String message = await openAIService.SuggestRep(
                        chatController.lastestMessage);
                    chatController.UpdateSuggestRep(message);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    margin: EdgeInsets.only(right: 10.sp, left: 10.sp),
                    decoration: BoxDecoration(
                      color: AppColors.send,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lightbulb,
                      size: 40.sp,
                      color: AppColors.white,
                    ),
                  ),
                )
              : SizedBox(),
        ),
        hintText: 'Add message...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.r),
        ),
      ),
      onTapOutside: (event) {
        if (event.position.dx >= 300 &&
            event.position.dx <= 400 &&
            event.position.dy >= 400 &&
            event.position.dy <= 500) return;
        chatController.isFocus.value = false;
        _focusNode.unfocus();
      },
      onTap: () {
        chatController.isFocus.value = true;
      },
    );
  }
}
