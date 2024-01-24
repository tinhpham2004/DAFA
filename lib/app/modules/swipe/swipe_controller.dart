import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';

class SwipeController extends GetxController {

  CardSwiperController cardSwiperController = CardSwiperController();
  RxString swipeState = ''.obs;
  RxInt curIndex = 0.obs;
  void UpdateSwipeState(String data) => swipeState.value = data;
  void UpdateCurIndex(int data) => curIndex.value = data;
}
