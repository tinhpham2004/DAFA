import 'package:dafa/app/models/match_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxInt currIndex = 0.obs;
  List<MatchUser> compatibleUserList = [];
  TextEditingController messageController = TextEditingController();

  void UpdateCurrIndex(int data) => currIndex.value = data;
}
