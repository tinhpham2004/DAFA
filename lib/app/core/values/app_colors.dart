import 'package:flutter/material.dart';

class AppColors {
  AppColors.__();
  static const LinearGradient primaryColor = LinearGradient(
    colors: [Color(0xFFEE805F), Color(0xFF4065EA)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const Color secondaryColor = Color(0XFF444142);
  static const Color thirdColor = Color(0xFF828693);
  static const Color white = Colors.white;
}
