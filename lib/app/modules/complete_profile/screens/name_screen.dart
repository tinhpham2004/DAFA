import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/complete_profile/widgets/back_icon.dart';
import 'package:dafa/app/modules/complete_profile/widgets/continue_button.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: const BackIcon(),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 110, top: 40),
                        child: AppIcons.logo,
                      ),
                    ],
                  ),
                ),

                //
                Container(
                  margin: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My name is',
                        style: CustomTextStyle.h1(Colors.black),
                      ),
                      //
                      Container(
                        width: 230,
                        margin: const EdgeInsets.only(left: 20, top: 30),
                        child: TextFormField(),
                      ),

                      //
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Text(
                          'Please, enter your name here.',
                          style: CustomTextStyle.h3(AppColors.thirdColor),
                        ),
                      ),

                      //
                      ContinueButton(route: AppRoutes.complete_birth_day),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
