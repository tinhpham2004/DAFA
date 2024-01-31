import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnonymousChatController extends GetxController {
  RxBool isSearching = false.obs;
  RxInt currIndex = 0.obs;
  bool isFirstTimeScroll = true;
  List<String> reportMessages = [];
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  RxBool reportCheckbox = false.obs;
  RxBool isFirstTimeLike = true.obs;
  bool isMatch = false;

  void UpdateIsSearching(bool data) => isSearching.value = data;
  void UpdateCurrIndex(int data) => currIndex.value = data;
  void UpdateIsFirstTimeScroll(bool data) => isFirstTimeScroll = data;
  void UpdateReportCheckbox(bool data) => reportCheckbox.value = data;
  void UpdateIsFirstTimeLike(bool data) => isFirstTimeLike.value = data;
  void UpdateIsMatch(bool data) => isMatch = data;
}
