import 'dart:io';

import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_text_style.dart';
import 'package:dafa/app/models/id_card_model.dart';
import 'package:dafa/app/models/id_recognition_response.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:dafa/app/services/database_service.dart';
import 'package:dafa/app/services/encrypt_service.dart';
import 'package:dafa/app/services/id_recognition_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class IdRecognitionScreen extends StatefulWidget {
  @override
  _IdRecognitionScreenState createState() => _IdRecognitionScreenState();
}

class _IdRecognitionScreenState extends State<IdRecognitionScreen> {
  bool isTermAccepted = false;
  File? _frontImage;
  File? _backImage;
  final ImagePicker _picker = ImagePicker();
  bool _isVerifying = false;

  Future<void> _pickImage(bool isFront) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      final croppedImg = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 8.5, ratioY: 5.5),
        compressQuality: 100,
      );
      if (croppedImg == null) return;
      setState(() {
        if (isFront) {
          _frontImage = File(croppedImg.path);
        } else {
          _backImage = File(croppedImg.path);
        }
      });
    }
  }

  Future<void> _requestPermission() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
  }

  void _showTermsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Terms for Users",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Before collecting ID card information, users will be notified and asked to agree to the terms related to the provision and processing of personal data. This includes information on the purpose of data collection, processing methods, and the users' rights regarding their personal data.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Data Encryption",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "To ensure information security, ID card data will be encrypted using the AES (Advanced Encryption Standard) algorithm before being stored in the database. AES is a robust and widely recognized encryption standard, protecting data from unauthorized access and ensuring that users' personal information is securely stored.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Legal Compliance",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "The age verification feature and data processing procedures comply with current legal regulations, including the Cybersecurity Law and Decree No. 13/2023/ND-CP. This ensures that personal data processing activities are carried out in accordance with legal provisions, protecting users' rights.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTermsBottomSheet(context);
    });
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    // _showTermsBottomSheet(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('ID Card Verification',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Front side of chip-based citizen ID card',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _pickImage(true),
              child: _frontImage != null
                  ? Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _frontImage!,
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Take Photo',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Back side of chip-based citizen ID card',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _pickImage(false),
              child: _backImage != null
                  ? Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _backImage!,
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : GestureDetector(
                      child: Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Take Photo',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
            ),
            const Spacer(),
            Row(
              children: [
                Checkbox(
                  value: isTermAccepted,
                  onChanged: (value) => setState(() {
                    isTermAccepted = !isTermAccepted;
                  }),
                ),
                const SizedBox(width: 10),
                const Flexible(
                    child: Text(
                  'I have read and agree to the terms and conditions.',
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        _isVerifying = true;
                      });
                      try {
                        // await Future.delayed(const Duration(seconds: 4));
                        if (_frontImage != null &&
                            _backImage != null &&
                            isTermAccepted) {
                          final idCardApiService = IDRecognitionService();
                          final response = await idCardApiService
                              .recognizeIDCard(_frontImage!.path);
                          if (response != null) {
                            final dob = DateFormat('dd/MM/yyyy')
                                .tryParse(response.data.first.dob);
                            if (dob != null && dob.year >= 18) {
                              final encryptService = EncryptService();
                              final databaseService = DatabaseService();
                              final encryptedIdNumber = encryptService
                                  .encrypt(response.data.first.id);
                              await databaseService.VerifyUser(
                                  encryptedIdNumber);
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.sp),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 300.h,
                                            child: Icon(
                                              Icons.check,
                                              size: 100.sp,
                                              color: AppColors.white,
                                            ),
                                            decoration: const BoxDecoration(
                                              color: AppColors.active,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 40.h),
                                            child: Text(
                                              'Verify Successfully!',
                                              style:
                                                  CustomTextStyle.cardTextStyle(
                                                AppColors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              Get.toNamed(AppRoutes.swipe);
                            } else {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.sp),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 300.h,
                                            child: Icon(
                                              Icons.close,
                                              size: 100.sp,
                                              color: AppColors.white,
                                            ),
                                            decoration: const BoxDecoration(
                                              color: AppColors.red,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 40.h),
                                            child: Text(
                                              'Age must be greater than 18',
                                              style:
                                                  CustomTextStyle.cardTextStyle(
                                                AppColors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          } else {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.sp),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 300.h,
                                          child: Icon(
                                            Icons.close,
                                            size: 100.sp,
                                            color: AppColors.white,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: AppColors.red,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 40.h),
                                          child: Text(
                                            'ID Card not recognized',
                                            style:
                                                CustomTextStyle.cardTextStyle(
                                              AppColors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                      } catch (e) {
                        print(e);
                      } finally {
                        setState(() {
                          _isVerifying = false;
                        });
                      }
                    },
                    child: Container(
                      constraints: BoxConstraints.tight(const Size(330, 50)),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(60.r),
                      ),
                      child: Center(
                        child: _isVerifying
                            ? CircularProgressIndicator(color: AppColors.white)
                            : Text(
                                'CONFIRM',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 15,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
