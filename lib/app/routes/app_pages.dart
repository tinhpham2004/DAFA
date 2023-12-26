import 'package:dafa/app/modules/auth/screens/auth_screen.dart';
import 'package:dafa/app/modules/auth/auth_binding.dart';
import 'package:dafa/app/routes/app_routes.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.auth,
      page: () => const AuthnScreen(),
      binding: SignInBinding(),
    )
  ];
}
