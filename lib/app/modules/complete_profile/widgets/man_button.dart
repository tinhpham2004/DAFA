import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/complete_profile/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManButton extends StatelessWidget {
  ManButton({
    super.key,
  });

  final CompleteProfileController completeProfileController =
      Get.find<CompleteProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      width: double.infinity,
      child: Obx(
        () => ElevatedButton(
          onPressed: () {
            completeProfileController.UpdateGender(1);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(230, 50),
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                width: 2,
                color: completeProfileController.gender.value == 1
                    ? Colors.purple
                    : AppColors.thirdColor,
              ),
            ),
          ),
          child: Text(
            'MAN',
            style: TextStyle(
              fontSize: 15,
              color: completeProfileController.gender.value == 1
                  ? Colors.purple
                  : AppColors.thirdColor,
            ),
          ),
        ),
      ),
    );
  }
}
