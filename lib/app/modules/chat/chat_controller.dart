import 'package:dafa/app/models/match_user.dart';
import 'package:dafa/app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxInt currIndex = 0.obs;
  List<MatchUser> compatibleUserList = [];
  TextEditingController messageController = TextEditingController();
  List<String> reportMessages = [];
  RxBool reportCheckbox = false.obs;
  ScrollController scrollController = ScrollController();
  RxString suggestRep = ''.obs;
  String lastestMessage = '';
  String callId = '';
  RxBool isBlock = false.obs;
  RxBool block = false.obs;
  RxBool isFocus = false.obs;

  void UpdateCurrIndex(int data) => currIndex.value = data;
  void UpdateReportCheckbox(bool data) => reportCheckbox.value = data;
  void UpdateSuggestRep(String data) => suggestRep.value = data;
  void UpdateLastestMessgage(String data) => lastestMessage = data;
}
