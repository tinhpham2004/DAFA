import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController smsCode1 = TextEditingController();
  TextEditingController smsCode2 = TextEditingController();
  TextEditingController smsCode3 = TextEditingController();
  TextEditingController smsCode4 = TextEditingController();
  TextEditingController smsCode5 = TextEditingController();
  TextEditingController smsCode6 = TextEditingController();

  RxString verificationId = ''.obs;
  RxString userId = ''.obs;
  RxBool checkOTP = true.obs;
  RxString validPassword = ''.obs;
  RxInt validPhoneNumber = 0.obs;

  void UpdateVerificationId(String data) => verificationId.value = data;

  void UpdateUserId(String data) => userId.value = data;

  void UpdateCheckOTP() => checkOTP.value = false;

  void UpdateValidPhoneNumber(int data) => validPhoneNumber.value = data;

  void UpdateValidPassword(String data) => validPassword.value = data;
}
