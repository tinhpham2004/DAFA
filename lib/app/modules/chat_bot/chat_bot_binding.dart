import 'package:dafa/app/modules/chat_bot/chat_bot_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:get/get.dart';

class ChatBotBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<ChatBotController>(() => ChatBotController());
  }
}