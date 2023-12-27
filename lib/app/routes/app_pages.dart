import 'package:dafa/app/modules/auth/screens/auth_screen.dart';
import 'package:dafa/app/modules/auth/auth_binding.dart';
import 'package:dafa/app/modules/sign_up/screens/otp_screen.dart';
import 'package:dafa/app/modules/sign_up/screens/password.dart';
import 'package:dafa/app/modules/sign_up/screens/sign_up_screen.dart';
import 'package:dafa/app/modules/sign_up/sign_up_binding.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.auth,
      page: () => const AuthnScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.sign_up,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OTPScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.password,
      page: () => const PasswordScreen(),
      binding: SignUpBinding(),
    ),
  ];
}