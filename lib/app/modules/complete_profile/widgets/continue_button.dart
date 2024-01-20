import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ContinueButton extends StatelessWidget {
  ContinueButton({
    super.key,
    required route,
  }) : _route = route;

  final String _route;
  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100.h),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(60.r),
      ),
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(_route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.r)),
        ),
        child: Text(
          'CONTINUE',
          style: TextStyle(
            fontSize: 30.sp,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
