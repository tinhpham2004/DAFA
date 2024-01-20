import 'package:dafa/app/global_widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwipeScreen extends StatelessWidget {
  const SwipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigation(onItem: 1),
        body: SingleChildScrollView(
          child: Container(
            height: 1600.h,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
