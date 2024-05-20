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
  String profile = '';
  String search = '';
  String swipe = '';
  String messages = '';
  String anonymousMatching = '';

  @override
  void initState() {
    _onItemTapped(widget.onItem);
    super.initState();
  }

  void RestLabel() {
    setState(() {
      profile = '';
      search = '';
      swipe = '';
      messages = '';
      anonymousMatching = '';
    });
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        RestLabel();
        setState(() {
          profile = 'Profile';
        });
        Get.toNamed(AppRoutes.profile);
        break;

      case 1:
        RestLabel();
        setState(() {
          search = 'Search';
        });
        Get.toNamed(AppRoutes.search);
        break;

      case 2:
        RestLabel();
        setState(() {
          swipe = 'Swipe';
        });
        Get.toNamed(AppRoutes.swipe);
        break;

      case 3:
        RestLabel();
        setState(() {
          messages = 'Messages';
        });
        Get.toNamed(AppRoutes.chat);
        break;

      case 4:
        RestLabel();
        setState(() {
          anonymousMatching = 'Explore';
        });
        Get.toNamed(AppRoutes.anonymous_chat);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[100],
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: widget.onItem != 0 ? AppColors.thirdColor : AppColors.send,
          ),
          label: profile,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: widget.onItem != 1 ? AppColors.thirdColor : AppColors.send,
          ),
          label: search,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: widget.onItem != 2 ? AppColors.thirdColor : AppColors.send,
          ),
          label: swipe,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
            color: widget.onItem != 3 ? AppColors.thirdColor : AppColors.send,
          ),
          label: messages,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_search_rounded,
            color: widget.onItem != 4 ? AppColors.thirdColor : AppColors.send,
          ),
          label: anonymousMatching,
        ),
      ],
      currentIndex: widget.onItem,
      selectedItemColor: AppColors.send,
      unselectedItemColor: AppColors.thirdColor,
      onTap: _onItemTapped,
    );
  }
}
