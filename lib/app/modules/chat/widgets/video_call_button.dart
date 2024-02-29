import 'package:dafa/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCallButton extends StatelessWidget {
  const VideoCallButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: AppColors.active),
      child: Icon(
        Icons.video_call_rounded,
        color: AppColors.white,
      ),
    );
  }
}