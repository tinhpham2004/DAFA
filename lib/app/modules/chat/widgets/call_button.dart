import 'dart:math';

import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/chat/screens/call_screen.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CallButton extends StatelessWidget {
  CallButton({
    super.key,
    required this.chatController,
    required this.isVideoCall,
  });

  final ChatController chatController;
  final bool isVideoCall;
  final SignInController signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
