import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/modules/profile/profile_controller.dart';
import 'package:dafa/app/modules/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HobbyField extends StatefulWidget {
  const HobbyField({
    super.key,
    required this.signInController,
    required this.profileController,
  });

  final SignInController signInController;
  final ProfileController profileController;

  @override
  State<HobbyField> createState() => _HobbyFieldState();
}

class _HobbyFieldState extends State<HobbyField> {
  late List<String> selectedHobbies;
  final List<String> hobbies = [
    'Gym',
    'Yoga',
    'Shopping',
    'Video games',
    'Chatting',
    'Coding',
    'Reading books',
    'Traveling',
    'Photography',
    'Gardening',
    'Cooking',
    'Painting',
    'Writing',
    'Dancing',
    'Hiking',
    'Playing musical instruments',
    'Watching movies',
    'Fishing',
    'Swimming',
    'Cycling'
  ];

  @override
  void initState() {
    super.initState();
    selectedHobbies = widget.signInController.user.hobby.split(', ');
  }

  void _showHobbySelectionDialog() {
    // Create a local copy of selected hobbies for the dialog
    List<String> tempSelectedHobbies = List.from(selectedHobbies);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Select Hobbies',
                style: CustomTextStyle.h3(AppColors.black),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: hobbies.map((hobby) {
                    return CheckboxListTile(
                      value: tempSelectedHobbies.contains(hobby),
                      title: Text(
                        hobby,
                        style: CustomTextStyle.h3(AppColors.black),
                      ),
                      fillColor: MaterialStateProperty.all(
                        tempSelectedHobbies.contains(hobby)
                            ? AppColors.send
                            : AppColors.white,
                      ),
                      onChanged: (isChecked) {
                        setState(() {
                          if (isChecked == true) {
                            tempSelectedHobbies.add(hobby);
                          } else {
                            tempSelectedHobbies.remove(hobby);
                          }
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: AppColors.send),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    selectedHobbies = List.from(tempSelectedHobbies);
                    widget.profileController.UpdateHobbies(selectedHobbies);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: AppColors.send),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showHobbySelectionDialog,
      child: InputDecorator(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Hobby',
          labelStyle: CustomTextStyle.h3(AppColors.thirdColor),
        ),
        child: Obx(() => Text(
              widget.profileController.hobby.value,
              style: CustomTextStyle.h3(AppColors.black),
            )),
      ),
    );
  }
}
