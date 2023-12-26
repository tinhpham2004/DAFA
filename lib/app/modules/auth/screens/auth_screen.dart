import 'package:dafa/app/core/values/app_colors.dart';
import 'package:dafa/app/core/values/app_icons.dart';
import 'package:flutter/material.dart';

class AuthnScreen extends StatelessWidget {
  const AuthnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(100, 200, 0, 20),
                child: Row(
                  children: [
                    // icon
                    Icon(
                      AppIcons.logo.icon,
                      color: Colors.white,
                      size: 70,
                    ),
                    const Text(
                      'DAFA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // message
              Container(
                margin: EdgeInsets.only(top: 100),
                child: const Text(
                  'Chào mừng bạn đến với DAFA - nơi bạn có thể tìm kiếm bạn bè cũng như nửa kia của mình!',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // sign_in button
              Container(
                margin: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(330, 50),
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // sign_up button
              Container(
                margin: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(330, 50),
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
