import 'package:get/get.dart';
import 'package:retoverse/presentations/pages/edit_profile_page.dart';
import 'package:retoverse/presentations/pages/forgot_password_page.dart';
import 'package:retoverse/presentations/pages/profile_page.dart';
import 'package:retoverse/presentations/pages/register_page.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/splash_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.SPLASH, page: () => SplashPage()),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginPage()),
    GetPage(name: AppRoutes.HOME, page: () => HomePage()),
    GetPage(name: AppRoutes.REGISTER, page: () => RegisterPage()),
    GetPage(name: AppRoutes.FORGOT_PASSWORD, page: () => ForgotPasswordPage()),
    GetPage(name: AppRoutes.PROFILE, page: () => ProfilePage()),
    GetPage(name: AppRoutes.EDITPROFILE, page: () => EditProfilePage()),
  ];
}
