import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/modules/chat/chat_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOutButton extends StatelessWidget {
  SignOutButton({
    super.key,
  });

  final signInController = Get.find<SignInController>();
  final databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.exit_to_app_rounded,
        color: AppColors.black,
        size: 60.sp,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sign out'),
              content: Text(
                'Time to head out? We\'ll miss you! Sign out to return anytime.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Action when 'No' is pressed
                    Get.back();
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () async {
                    signInController.user.isOnline = false;
                    databaseService.UpdateUserData(signInController.user);
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.remove("phoneNumber");
                    Get.back();
                    Get.deleteAll();
                    Get.offAllNamed(AppRoutes.auth);
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
