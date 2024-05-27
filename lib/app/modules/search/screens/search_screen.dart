import 'dart:math';

import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/global_widgets/bottom_navigation.dart';
import 'package:dafa/app/models/match_user.dart';
import 'package:dafa/app/modules/search/widgets/view_profile.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/modules/swipe/swipe_controller.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _focusNode = FocusNode();

  final searchTextController = TextEditingController();
  final signInController = Get.find<SignInController>();
  final swipeController = Get.find<SwipeController>();
  final databaseService = DatabaseService();

  List<String> _selectedAge = List.generate(82, (index) {
    int value = 18 + index;
    return value.toString();
  });
  List<String> _selectedHeight = List.generate(46, (index) {
        int value = 145 + index;
        return value.toString() + "cm";
      }) +
      [''];
  List<String> _selectedHobby = [
    'Gym',
    'Yoga',
    'Shopping',
    'Video games',
    'Chat',
    'Coding',
    ''
  ];

  final age = List.generate(82, (index) {
    int value = 18 + index;
    return value.toString();
  }).map((item) => MultiSelectItem<String>(item, item)).toList();

  final height = List.generate(46, (index) {
    int value = 145 + index;
    return value.toString() + "cm";
  }).map((item) => MultiSelectItem<String>(item, item)).toList();

  final hobby = ['Gym', 'Yoga', 'Shopping', 'Video games', 'Chat', 'Coding']
      .map((item) => MultiSelectItem<String>(item, item))
      .toList();

  List<MatchUser> searchResult = [];

  String LastActiveTime(Duration diff) {
    int year = (diff.inDays / 365).round();
    int month = (diff.inDays / 30).round();
    int day = diff.inDays;
    int hour = diff.inHours;
    int minute = diff.inMinutes;
    int second = diff.inSeconds;
    if (year > 0) {
      return year == 1 ? '1 year ago' : '$year years ago';
    }
    if (month > 0) {
      return month == 1 ? '1 month ago' : '$month months ago';
    }
    if (day > 0) {
      return day == 1 ? '1 day ago' : '$day days ago';
    }
    if (hour > 0) {
      return hour == 1 ? '1 hour ago' : '$hour hours ago';
    }
    if (minute > 0) {
      return minute == 1 ? '1 minute ago' : '$minute minutes ago';
    }
    if (second > 0) {
      return second == 1 ? '1 second ago' : '$minute seconds ago';
    }
    return 'just a moment';
  }

  int _getMatchListIndex(String phoneNumber) {
    for (int i = 0; i < signInController.matchList.length - 1; i++) {
      if (signInController.matchList[i].user!.phoneNumber == phoneNumber) {
        return i;
      }
    }
    return -1;
  }

  void _filter() {
    setState(() {
      searchResult = [];
    });
    final users = signInController.matchList;

    users.forEach((element) {
      if (element.user != null) {
        final userAge = (DateTime.now().year -
                int.parse(element.user!.dateOfBirth.substring(6)))
            .toString();
        int _index = _getMatchListIndex(element.user!.phoneNumber);
        if (element.user!.name.contains(searchTextController.value.text) &&
            _selectedAge.contains(userAge) &&
            _selectedHeight.contains(element.user!.height) &&
            _selectedHobby.contains(element.user!.hobby) &&
            _index >= swipeController.curIndex.value) {
          setState(() {
            searchResult.add(element);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: searchTextController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 0, bottom: 10.sp, left: 25.sp),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      suffix: GestureDetector(
                        onTap: () {
                          _filter();
                        },
                        child: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                    onTapOutside: (event) {
                      _focusNode.unfocus();
                    },
                  ),
                  Wrap(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30.h),
                        child: MultiSelectDialogField(
                          items: age,
                          title: Text("Age"),
                          selectedColor: Colors.blue,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(),
                          ),
                          buttonIcon: Icon(
                            Icons.onetwothree,
                          ),
                          buttonText: Text(
                            "Age",
                            style: CustomTextStyle.h3(AppColors.black),
                          ),
                          onConfirm: (results) {
                            _selectedAge = results;
                            if (results.isEmpty) {
                              _selectedAge = List.generate(82, (index) {
                                int value = 18 + index;
                                return value.toString();
                              });
                            }
                            _filter();
                          },
                        ),
                      ),
                      ///////////////////////////
                      //////////////////////////
                      Container(
                        margin: EdgeInsets.only(top: 30.h),
                        child: MultiSelectDialogField(
                          items: height,
                          title: Text("Height"),
                          selectedColor: Colors.blue,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(),
                          ),
                          buttonIcon: Icon(
                            Icons.straighten_rounded,
                          ),
                          buttonText: Text(
                            "Height",
                            style: CustomTextStyle.h3(AppColors.black),
                          ),
                          onConfirm: (results) {
                            _selectedHeight = results;
                            if (results.isEmpty) {
                              _selectedHeight = List.generate(46, (index) {
                                    int value = 145 + index;
                                    return value.toString() + "cm";
                                  }) +
                                  [''];
                            }
                            _filter();
                          },
                        ),
                      ),
                      ///////////////////////////
                      //////////////////////////
                      Container(
                        margin: EdgeInsets.only(top: 30.h),
                        child: MultiSelectDialogField(
                          items: hobby,
                          title: Text("Hobby"),
                          selectedColor: Colors.blue,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(),
                          ),
                          buttonIcon: Icon(
                            Icons.favorite_outline_sharp,
                          ),
                          buttonText: Text(
                            "Hobby",
                            style: CustomTextStyle.h3(AppColors.black),
                          ),
                          onConfirm: (results) {
                            _selectedHobby = results;
                            if (results.isEmpty) {
                              _selectedHobby = [
                                'Gym',
                                'Yoga',
                                'Shopping',
                                'Video games',
                                'Chat',
                                'Coding',
                                '',
                              ];
                            }
                            _filter();
                          },
                        ),
                      ),
                      ///////////////////////
                      //////////////////////
                      searchResult.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: searchResult.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // chatController.UpdateCurrIndex(index);
                                    // Get.toNamed(AppRoutes.message);
                                    Get.to(ViewProfile(
                                        matchUser: searchResult[index]));
                                  },
                                  child: ListTile(
                                    leading: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          height: 150.h,
                                          width: 100.w,
                                          child: searchResult[index]
                                                  .user!
                                                  .images
                                                  .isNotEmpty
                                              ? CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      searchResult[index]
                                                          .user!
                                                          .images
                                                          .first),
                                                )
                                              : SizedBox(),
                                        ),
                                        Obx(() => Container(
                                              decoration: BoxDecoration(
                                                color: signInController
                                                                .listUsersOnlineState[
                                                            searchResult[index]
                                                                .user!
                                                                .phoneNumber] ==
                                                        true
                                                    ? AppColors.active
                                                    : AppColors
                                                        .disabledBackground,
                                                shape: BoxShape.circle,
                                              ),
                                              height: 20.h,
                                              width: 20.w,
                                            )),
                                      ],
                                    ),
                                    title: Text(
                                      searchResult[index].user!.name,
                                    ),
                                    subtitle: Text(
                                      'Last active • ' +
                                          LastActiveTime(
                                            DateTime.now().difference(
                                                searchResult[index]
                                                    .user!
                                                    .lastActive),
                                          ),
                                    ),
                                    trailing: Wrap(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            signInController.likeList.add(
                                                searchResult[index]
                                                    .user!
                                                    .phoneNumber);
                                            if (await databaseService
                                                .CheckIsLike(searchResult[index]
                                                    .user!
                                                    .phoneNumber)) {
                                              signInController.compatibleList
                                                  .add(searchResult[index]
                                                      .user!
                                                      .phoneNumber);
                                              databaseService
                                                  .UpdateCompatibleList(
                                                      searchResult[index]
                                                          .user!
                                                          .phoneNumber);
                                              await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.sp),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 300.h,
                                                            child:
                                                                AppIcons.logo,
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        40.h),
                                                            child: Text(
                                                              'Double tap magic! You and ${searchResult[index].user!.name} are a match. Say hi and see where things go!✨',
                                                              style: CustomTextStyle
                                                                  .cardTextStyle(
                                                                AppColors.black,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                            databaseService.UpdateMatchedList();
                                            int _index = _getMatchListIndex(
                                                searchResult[index]
                                                    .user!
                                                    .phoneNumber);
                                            signInController.matchList
                                                .removeAt(_index);
                                            _filter();
                                          },
                                          child: Icon(
                                            Icons.favorite,
                                            size: 50.sp,
                                            color: AppColors.pink,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40.w,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            signInController.dislikeList.add(
                                                searchResult[index]
                                                    .user!
                                                    .phoneNumber);
                                            databaseService.UpdateMatchedList();
                                            int _index = _getMatchListIndex(
                                                searchResult[index]
                                                    .user!
                                                    .phoneNumber);
                                            signInController.matchList
                                                .removeAt(_index);
                                            _filter();
                                          },
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: 50.sp,
                                            color: AppColors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                'No results found for your search',
                                style: CustomTextStyle.error_text_style(),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigation(
            onItem: 1,
          ),
        ),
      ),
    );
  }
}
