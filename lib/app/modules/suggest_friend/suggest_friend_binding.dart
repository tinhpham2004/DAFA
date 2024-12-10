import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/suggest_friend/suggest_friend_controller.dart';
import 'package:get/get.dart';

class SuggestFriendBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<SuggestFriendController>(() => SuggestFriendController());
  }
}
