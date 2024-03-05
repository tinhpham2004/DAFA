import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIcons {
  AppIcons.__();
  // static const GradientIcon logo = GradientIcon(
  //   icon: Icons.favorite,
  //   gradient: AppColors.primaryColor,
  //   size: 50,
  // );

  static Tab logo = Tab(
    icon: Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.cover,
    ),
    height: 120.sp,
  );
}
