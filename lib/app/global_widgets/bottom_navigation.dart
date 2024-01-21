import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
        {
          Get.toNamed(AppRoutes.profile);
          break;
        }
      case 1:
        {
          Get.toNamed(AppRoutes.swipe);
          break;
        }
      case 2:
        {
          Get.toNamed(AppRoutes.chat);
          break;
        }
      case 3:
        {
          Get.toNamed(AppRoutes.anonym_chat);
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: '',
        ),
      ],
      currentIndex: widget.onItem,
      selectedItemColor: AppColors.secondaryColor,
      unselectedItemColor: AppColors.thirdColor,
      onTap: _onItemTapped,
    );
  }
}
