import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/complete_profile/widgets/back_icon.dart';
import 'package:dafa/app/modules/complete_profile/widgets/birthday_field.dart';
import 'package:dafa/app/modules/complete_profile/widgets/continue_button.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class BirthDayScreen extends StatelessWidget {
  const BirthDayScreen({super.key});

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
                        'My birthday is',
                        style: CustomTextStyle.h1(Colors.black),
                      ),
                      //
                      Container(
                        width: 230,
                        margin: const EdgeInsets.only(left: 20, top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              width: 20,
                              child: BirthdayField(),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 30,
                              width: 20,
                              child: BirthdayField(),
                            ),
                            //
                            Container(
                              margin: EdgeInsets.only(left: 4, bottom: 5),
                              child: Text(
                                '/',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: AppColors.secondaryColor),
                              ),
                            ),
                            //
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 30,
                              width: 20,
                              child: BirthdayField(),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 30,
                              width: 20,
                              child: BirthdayField(),
                            ),
                            //
                            Container(
                              margin: EdgeInsets.only(left: 4, bottom: 5),
                              child: Text(
                                '/',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: AppColors.secondaryColor),
                              ),
                            ),
                            //
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 30,
                              width: 20,
                              child: BirthdayField(),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 30,
                              width: 20,
                              child: BirthdayField(),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 30,
                              width: 20,
                              child: BirthdayField(),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 30,
                              width: 20,
                              child: BirthdayField(),
                            ),
                          ],
                        ),
                      ),

                      //
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Text(
                          'Please, enter your birthday here so that other people can know your age.',
                          style: CustomTextStyle.h3(AppColors.thirdColor),
                        ),
                      ),

                      //
                      ContinueButton(route: AppRoutes.complete_gerder),
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
