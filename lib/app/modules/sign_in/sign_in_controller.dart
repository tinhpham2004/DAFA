import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString signInState = 'Sign in with your phone number and password that you signed up before.'.obs;
  void UpdateSignInState(String data) => signInState.value = data;
}
