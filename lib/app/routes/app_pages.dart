import 'package:dafa/app/modules/sign_in/screens/sign_in_screen.dart';
import 'package:dafa/app/modules/sign_in/sign_in_binding.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.sign_in,
      page: () => const SignInScreen(),
      binding: SignInBinding(),
    )
  ];
}
