import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController bio = TextEditingController();
  RxString height = ''.obs;
  RxString hobby = ''.obs;
  RxString job = ''.obs;

  List<RxString> imgUrl = [''.obs, ''.obs, ''.obs, ''.obs, ''.obs, ''.obs];
  RxBool errorImages = false.obs;

  void UpdateImgUrl(int index, String data) => imgUrl[index].value = data;
  void UpdateHeight(String data) => height.value = data;
  void UpdateHobbies(List<String> data) => hobby.value = data.join(', ');
  void UpdateJob(String data) => job.value = data;
  void UpdateErrorImages(bool data) => errorImages.value = data;
}
