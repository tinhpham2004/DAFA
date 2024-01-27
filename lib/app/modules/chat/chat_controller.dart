import 'package:dafa/app/models/match_user.dart';
import 'package:dafa/app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxInt currIndex = 0.obs;
  List<MatchUser> compatibleUserList = [];
  Map<String, Message> lastMessae = Map();
  TextEditingController messageController = TextEditingController();
  List<String> reportMessages = [];
  RxBool reportCheckbox = false.obs;
  ScrollController scrollController = ScrollController();
  bool isFirstTimeScroll = true;

  void UpdateCurrIndex(int data) => currIndex.value = data;
  void UpdateReportCheckbox(bool data) => reportCheckbox.value = data;
  void UpdateIsFirstTimeScroll(bool data) => isFirstTimeScroll = data;
}
