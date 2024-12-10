import 'package:dafa/app/global_widgets/bottom_navigation.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/suggest_friend/suggest_friend_controller.dart';
import 'package:dafa/app/modules/suggest_friend/widgets/card_swipable.dart';
import 'package:dafa/app/modules/suggest_friend/widgets/dislike_button.dart';
import 'package:dafa/app/modules/suggest_friend/widgets/like.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuggestFriendScreen extends StatefulWidget {
  SuggestFriendScreen({super.key});

  @override
  State<SuggestFriendScreen> createState() => _SuggestFriendScreenState();
}

class _SuggestFriendScreenState extends State<SuggestFriendScreen> with WidgetsBindingObserver {
  final SignInController signInController = Get.find<SignInController>();

  final SuggestFriendController suggestFriendController = Get.find<SuggestFriendController>();

  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              CardSwipable(),
              Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      DislikeButton(
                        suggestFriendController: suggestFriendController,
                      ),
                      LikeButton(
                        suggestFriendController: suggestFriendController,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
