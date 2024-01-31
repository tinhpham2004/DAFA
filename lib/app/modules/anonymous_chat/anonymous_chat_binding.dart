import 'package:dafa/app/modules/anonymous_chat/anonymous_chat_controller.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/swipe/swipe_controller.dart';
import 'package:get/get.dart';

class AnonymousChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<SwipeController>(() => SwipeController());
    Get.lazyPut<AnonymousChatController>(() => AnonymousChatController());
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
