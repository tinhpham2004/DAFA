import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/global_widgets/bottom_navigation.dart';
import 'package:dafa/app/modules/profile/profile_controller.dart';
import 'package:dafa/app/modules/profile/widgets/add_image.dart';
import 'package:dafa/app/modules/profile/widgets/bio_field.dart';
import 'package:dafa/app/modules/profile/widgets/height_field.dart';
import 'package:dafa/app/modules/profile/widgets/hobby_field.dart';
import 'package:dafa/app/modules/profile/widgets/save_button.dart';
import 'package:dafa/app/modules/profile/widgets/sign_out_button.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  LocationService locationService = LocationService();
  final SignInController signInController = Get.find<SignInController>();
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    for (int index = 0; index < signInController.user.images.length; index++) {
      profileController.UpdateImgUrl(
          index, signInController.user.images[index]);
    }
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            title: ListTile(
              title: Text(
                'Profile',
                style: CustomTextStyle.profileHeader(
                  AppColors.black,
                ),
              ),
              trailing: SignOutButton(),
            ),
          ),
          bottomNavigationBar: BottomNavigation(
            onItem: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 40.w, top: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Images',
                      style: CustomTextStyle.profileHeader(AppColors.black),
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    childAspectRatio: 0.75,
                    children: List.generate(
                      6,
                      (index) {
                        return AddImage(index: index);
                      },
                    ),
                  ),

                  //
                  Container(
                    margin: EdgeInsets.only(top: 100.h),
                    child: Text(
                      'Bio',
                      style: CustomTextStyle.profileHeader(AppColors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.h, right: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        width: 1.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 20.w),
                      child: BioField(
                        profileController: profileController,
                        signInController: signInController,
                      ),
                    ),
                  ),

                  //
                  Container(
                    margin: EdgeInsets.only(top: 100.h),
                    child: Text(
                      'Basic Information',
                      style: CustomTextStyle.profileHeader(AppColors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.h, right: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.disabledBackground,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        width: 1.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 20.w),
                      child: TextFormField(
                        initialValue: signInController.user.name,
                        readOnly: true,
                        style: CustomTextStyle.h3(AppColors.black),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.lock),
                          labelText: 'Name',
                          labelStyle: CustomTextStyle.h3(AppColors.thirdColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  //
                  Container(
                    margin: EdgeInsets.only(top: 40.h, right: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.disabledBackground,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        width: 1.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 20.w),
                      child: TextFormField(
                        initialValue: (DateTime.now().year -
                                int.parse(signInController.user.dateOfBirth
                                    .substring(6)))
                            .toString(),
                        readOnly: true,
                        style: CustomTextStyle.h3(AppColors.black),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.lock),
                          labelText: 'Age',
                          labelStyle: CustomTextStyle.h3(AppColors.thirdColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  //
                  Container(
                    margin: EdgeInsets.only(top: 40.h, right: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.disabledBackground,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        width: 1.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 20.w),
                      child: TextFormField(
                        initialValue: signInController.user.address,
                        readOnly: true,
                        style: CustomTextStyle.h3(AppColors.black),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.lock),
                          labelText: 'Address',
                          labelStyle: CustomTextStyle.h3(AppColors.thirdColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  //
                  Container(
                    margin: EdgeInsets.only(top: 40.h, right: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.disabledBackground,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        width: 1.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 20.w),
                      child: TextFormField(
                        initialValue: signInController.user.gender,
                        readOnly: true,
                        style: CustomTextStyle.h3(AppColors.black),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.lock),
                          labelText: 'Gender',
                          labelStyle: CustomTextStyle.h3(AppColors.thirdColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  //
                  Container(
                    margin: EdgeInsets.only(top: 40.h, right: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        width: 1.0,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: HeightField(
                          signInController: signInController,
                          profileController: profileController),
                    ),
                  ),

                  //
                  Container(
                    margin: EdgeInsets.only(top: 40.h, right: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        width: 1.0,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: HobbyField(
                          signInController: signInController,
                          profileController: profileController),
                    ),
                  ),
                  Obx(
                    () => profileController.errorImages.value == true
                        ? Container(
                            margin: EdgeInsets.only(top: 40.h),
                            child: Text(
                              'Please select at least 3 images.',
                              style: CustomTextStyle.error_text_style(),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 60.h),
                          ),
                  ),

                  //
                  SaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


