import 'package:get/get.dart';

class CompleteProfileController extends GetxController {
  RxInt gender = 0.obs;
  RxString imgUrl1 = ''.obs;
  RxString imgUrl2 = ''.obs;
  RxString imgUrl3 = ''.obs;
  RxString imgUrl4 = ''.obs;
  RxString imgUrl5 = ''.obs;
  RxString imgUrl6 = ''.obs;
  void UpdateGender(int data) => gender.value = data;
  void UpdateImgUrl1(String data) => imgUrl1.value = data;
  void UpdateImgUrl2(String data) => imgUrl2.value = data;
  void UpdateImgUrl3(String data) => imgUrl3.value = data;
  void UpdateImgUrl4(String data) => imgUrl4.value = data;
  void UpdateImgUrl5(String data) => imgUrl5.value = data;
  void UpdateImgUrl6(String data) => imgUrl6.value = data;
}
