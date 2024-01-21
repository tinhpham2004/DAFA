import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CompleteProfileController extends GetxController {
  RxInt gender = 0.obs;
  TextEditingController dateOB1 = TextEditingController();
  TextEditingController dateOB2 = TextEditingController();
  TextEditingController dateOB3 = TextEditingController();
  TextEditingController dateOB4 = TextEditingController();
  TextEditingController dateOB5 = TextEditingController();
  TextEditingController dateOB6 = TextEditingController();
  TextEditingController dateOB7 = TextEditingController();
  TextEditingController dateOB8 = TextEditingController();
  TextEditingController name = TextEditingController();
  RxBool errorName = false.obs;
  RxBool errorDate = false.obs;
  RxBool errorGender = false.obs;
  RxBool errorImages = false.obs;
  List<RxString> imgUrl = [''.obs, ''.obs, ''.obs, ''.obs, ''.obs, ''.obs];

  void UpdateGender(int data) => gender.value = data;
  void UpdateErrorName(bool data) => errorName.value = data;
  void UpdateErrorDate(bool data) => errorDate.value = data;
  void UpdateErrorGender(bool data) => errorGender.value = data;
  void UpdateErrorImages(bool data) => errorImages.value = data;

  void UpdateImgUrl(int index, String data) => imgUrl[index].value = data;
}
