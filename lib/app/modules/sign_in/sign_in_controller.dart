import 'package:dafa/app/models/app_user.dart';
import 'package:dafa/app/models/match_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString signInState =
      'Sign in with your phone number and password that you signed up before.'
          .obs;
  AppUser user = AppUser(
    phoneNumber: '',
  );
  RxBool obscure = true.obs;
  List<MatchUser> matchList = [];
  List<String> likeList = [];
  List<String> dislikeList = [];
  List<String> compatibleList = [];
  Map<String, int>? getToKnowList;
  List<MatchUser> matchListForChat = [];
  RxMap<String, bool> listUsersOnlineState = RxMap<String, bool>();
  RxMap<String, bool> listUsersSearchingState = RxMap<String, bool>();
  Map<String, String> listUsersGender = Map();
  Map<String, List<String>> graphMatchUser = Map();
  String notifySenderId = '';

  void UpdateSignInState(String data) => signInState.value = data;
  void UpdateUser(AppUser data) => user = data;
  void UpdateObscure(bool data) => obscure.value = data;
}
