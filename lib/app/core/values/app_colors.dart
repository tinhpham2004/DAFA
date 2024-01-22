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
  static const Color black = Colors.black;
  static const Color red = Color.fromARGB(255, 231, 41, 27);
  static const Color pink = Color.fromARGB(255, 221, 76, 124);
  static const Color backgroundColor = Color.fromARGB(255, 24, 23, 23);
  static const Color cardTextColor = Color.fromARGB(209, 255, 255, 255);
  static const Color disabledBackground = Color.fromARGB(255, 186, 189, 198);
}
