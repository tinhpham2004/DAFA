import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BottomNavigation extends StatefulWidget {
  late int onItem;
  BottomNavigation({super.key, required this.onItem});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.profile);
        break;

      case 1:
        Get.toNamed(AppRoutes.swipe);
        break;

      case 2:
        Get.toNamed(AppRoutes.chat);
        break;

      case 3:
        Get.toNamed(AppRoutes.anonymous_chat);
        break;

      case 4:
        Get.toNamed(AppRoutes.chat_bot);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.primaryColor),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: AppColors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: AppColors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: AppColors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble,
              color: AppColors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.android,
              color: AppColors.white,
            ),
            label: '',
          ),
        ],
        currentIndex: widget.onItem,
        selectedItemColor: AppColors.secondaryColor,
        unselectedItemColor: AppColors.thirdColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
