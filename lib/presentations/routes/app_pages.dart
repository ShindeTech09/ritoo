import 'package:get/get.dart';
import 'package:retoverse/core/bindings/home_binding.dart';
import 'package:retoverse/core/bindings/product_binding.dart';
import 'package:retoverse/presentations/pages/auth_page/edit_profile_page.dart';
import 'package:retoverse/presentations/pages/auth_page/home_page.dart';
import 'package:retoverse/presentations/pages/product_page/product_list_page.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

import '../pages/auth_page/forgot_password_page.dart';
import '../pages/auth_page/login_page.dart';
import '../pages/auth_page/profile_page.dart';
import '../pages/auth_page/register_page.dart';
import '../pages/auth_page/splash_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.SPLASH, page: () => SplashPage()),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginPage()),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.REGISTER, page: () => RegisterPage()),
    GetPage(name: AppRoutes.FORGOT_PASSWORD, page: () => ForgotPasswordPage()),
    GetPage(name: AppRoutes.PROFILE, page: () => ProfilePage()),
    GetPage(name: AppRoutes.EDITPROFILE, page: () => EditProfilePage()),
    GetPage(
      name: AppRoutes.PRODUCT_LIST,
      page: () => ProductListPage(),
      binding: ProductBinding(),
    ),
  ];
}
