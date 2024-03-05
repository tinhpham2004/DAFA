import 'package:dafa/app/modules/complete_profile/complete_profile_controller.dart';
import 'package:get/get.dart';

class CompleteProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteProfileController>(() => CompleteProfileController());
  }
}