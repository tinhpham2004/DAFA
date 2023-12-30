import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/complete_profile/complete_profile_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FinishButton extends StatelessWidget {
  FinishButton({
    super.key,
  });
  final CompleteProfileController completeProfileController =
      Get.find<CompleteProfileController>();
  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: () async {
          await databaseService.UpdateUserImage(
              1, completeProfileController.imgUrl1.value);
          await databaseService.UpdateUserImage(
              2, completeProfileController.imgUrl2.value);
          await databaseService.UpdateUserImage(
              3, completeProfileController.imgUrl3.value);
          await databaseService.UpdateUserImage(
              4, completeProfileController.imgUrl4.value);
          await databaseService.UpdateUserImage(
              5, completeProfileController.imgUrl5.value);
          await databaseService.UpdateUserImage(
              6, completeProfileController.imgUrl6.value);
          Get.toNamed(AppRoutes.swipe);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text(
          'FINSIH',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
