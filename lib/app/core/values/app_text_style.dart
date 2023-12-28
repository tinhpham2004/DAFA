import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextStyle extends TextStyle {
  static TextStyle h1(Color color) {
    return TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle h2(Color color) {
    return TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle h3(Color color) {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

    static TextStyle error_text_style() {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.red,
    );
  }
}