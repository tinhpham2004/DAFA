import 'package:get/get.dart';

class CompleteProfileController extends GetxController {
  RxInt gender = 0.obs;
  RxString imgUrl1 = ''.obs;
  RxString imgUrl2 = ''.obs;
  RxString imgUrl3 = ''.obs;
  RxString imgUrl4 = ''.obs;
  RxString imgUrl5 = ''.obs;
  RxString imgUrl6 = ''.obs;

  RxString imgDownloadUrl1 = ''.obs;
  RxString imgDownloadUrl2 = ''.obs;
  RxString imgDownloadUrl3 = ''.obs;
  RxString imgDownloadUrl4 = ''.obs;
  RxString imgDownloadUrl5 = ''.obs;
  RxString imgDownloadUrl6 = ''.obs;

  void UpdateGender(int data) => gender.value = data;
  void UpdateImgUrl1(String data) => imgUrl1.value = data;
  void UpdateImgUrl2(String data) => imgUrl2.value = data;
  void UpdateImgUrl3(String data) => imgUrl3.value = data;
  void UpdateImgUrl4(String data) => imgUrl4.value = data;
  void UpdateImgUrl5(String data) => imgUrl5.value = data;
  void UpdateImgUrl6(String data) => imgUrl6.value = data;

  void UpdateImgDownloadUrl1(String data) => imgDownloadUrl1.value = data;
  void UpdateImgDownloadUrl2(String data) => imgDownloadUrl2.value = data;
  void UpdateImgDownloadUrl3(String data) => imgDownloadUrl3.value = data;
  void UpdateImgDownloadUrl4(String data) => imgDownloadUrl4.value = data;
  void UpdateImgDownloadUrl5(String data) => imgDownloadUrl5.value = data;
  void UpdateImgDownloadUrl6(String data) => imgDownloadUrl6.value = data;
}
