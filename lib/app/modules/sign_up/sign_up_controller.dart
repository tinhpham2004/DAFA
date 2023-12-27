import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString verificationId = ''.obs;
  RxString smsCode = ''.obs;
  RxString userId = ''.obs;

  void UpdateVerificationId(String data) => verificationId.value = data;
  void UpdateSmsCode(String data) {
    if (smsCode.value.length <= 5)
      smsCode.value += data;
    else
      smsCode.value = data;
  }
  void UpdateUserId(String data) => userId.value = data;
}
