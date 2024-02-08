import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    super.key,
  });

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
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.remove("phoneNumber");
                    Get.back();
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