import 'package:dafa/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class AppIcons {
  AppIcons.__();
  static const GradientIcon logo = GradientIcon(
    icon: Icons.favorite,
    gradient: AppColors.primaryColor,
    size: 50,
  );
}
