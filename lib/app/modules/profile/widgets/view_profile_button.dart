import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewProfileButton extends StatelessWidget {
  const ViewProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.toNamed(AppRoutes.view_user_profile);
      },
      icon: Icon(
        Icons.remove_red_eye_outlined,
        color: AppColors.black,
        size: 60.sp,
      ),
    );
  }
}
