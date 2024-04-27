import 'package:dafa/app/modules/anonymous_chat/anonymous_chat_binding.dart';
import 'package:dafa/app/modules/anonymous_chat/screens/anonymous_chat_screen.dart';
import 'package:dafa/app/modules/anonymous_chat/screens/anonymous_message_screen.dart';
import 'package:dafa/app/modules/auth/screens/auth_screen.dart';
import 'package:dafa/app/modules/auth/auth_binding.dart';
import 'package:dafa/app/modules/chat/chat_binding.dart';
import 'package:dafa/app/modules/chat/screens/chat_screen.dart';
import 'package:dafa/app/modules/chat/screens/message_screen.dart';
import 'package:dafa/app/modules/chat/widgets/view_profile.dart';
import 'package:dafa/app/modules/chat_bot/chat_bot_binding.dart';
import 'package:dafa/app/modules/chat_bot/screens/chat_bot_screen.dart';
import 'package:dafa/app/modules/complete_profile/complete_profile_binding.dart';
import 'package:dafa/app/modules/complete_profile/screens/birth_day_screen.dart';
import 'package:dafa/app/modules/complete_profile/screens/gender_screen.dart';
import 'package:dafa/app/modules/complete_profile/screens/name_screen.dart';
import 'package:dafa/app/modules/complete_profile/screens/upload_images_screen.dart';
import 'package:dafa/app/modules/profile/screens/profile_screen.dart';
import 'package:dafa/app/modules/profile/profile_binding.dart';
import 'package:dafa/app/modules/profile/widgets/view_user_profile.dart';
import 'package:dafa/app/modules/sign_in/screens/sign_in_screen.dart';
import 'package:dafa/app/modules/sign_in/sign_in_binding.dart';
import 'package:dafa/app/modules/sign_up/screens/otp_screen.dart';
import 'package:dafa/app/modules/sign_up/screens/password.dart';
import 'package:dafa/app/modules/sign_up/screens/sign_up_screen.dart';
import 'package:dafa/app/modules/sign_up/sign_up_binding.dart';
import 'package:dafa/app/modules/swipe/screens/swipe_screen.dart';
import 'package:dafa/app/modules/swipe/swipe_binding.dart';
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
      page: () => OTPScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.password,
      page: () => PasswordScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.sign_in,
      page: () => SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.complete_name,
      page: () => NameScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.complete_birth_day,
      page: () => BirthDayScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.complete_gerder,
      page: () => GenderScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.complete_upload_images,
      page: () => UploadImagesScreen(),
      binding: CompleteProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.swipe,
      page: () => SwipeScreen(),
      binding: SwipeBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.view_user_profile,
      page: () => ViewUserProfile(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => ChatScreen(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.message,
      page: () => MessageScreen(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.view_profile,
      page: () => ViewProfile(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.anonymous_chat,
      page: () => AnonymousChatScreen(),
      binding: AnonymousChatBinding(),
    ),
    GetPage(
      name: AppRoutes.anonymous_message,
      page: () => AnonymouseMessageScreen(),
      binding: AnonymousChatBinding(),
    ),
    GetPage(
      name: AppRoutes.chat_bot,
      page: () => ChatBotScreen(),
      binding: ChatBotBinding(),
    ),
  ];
}
