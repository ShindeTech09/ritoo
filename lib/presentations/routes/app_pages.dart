import 'package:get/get.dart';
import 'package:retoverse/core/bindings/auth_bindings.dart';
import 'package:retoverse/core/bindings/product_binding.dart';
import 'package:retoverse/dummy.dart';
import 'package:retoverse/presentations/pages/auth_page/edit_profile_page.dart';
import 'package:retoverse/presentations/pages/cart_page/add_address_page.dart';
import 'package:retoverse/presentations/pages/cart_page/cart_page.dart';
import 'package:retoverse/presentations/pages/product_page/product_detail_page.dart';
import 'package:retoverse/presentations/pages/product_page/product_list_page.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

import '../pages/auth_page/forgot_password_page.dart';
import '../pages/auth_page/login_page.dart';
import '../pages/auth_page/profile_page.dart';
import '../pages/auth_page/register_page.dart';
import '../pages/auth_page/splash_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.FORGOT_PASSWORD,
      page: () => ForgotPasswordPage(),
      binding: AuthBindings(),
    ),

    GetPage(
      name: AppRoutes.EDITPROFILE,
      page: () => EditProfilePage(),
      binding: AuthBindings(),
    ),

    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterPage(),
      binding: AuthBindings(),
    ),

    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_LIST,
      page: () => ProductListPage(),
      bindings: [
        ProductBinding(),
        // CartBinding(), // ✅ cart ready in product list
      ],
    ),
    GetPage(
      name: AppRoutes.PRODUCT_DETAIL,
      page: () => ProductDetailPage(product: Get.find()),
      bindings: [
        ProductBinding(),
        // CartBinding(), // ✅ cart ready in product detail
      ],
    ),
    GetPage(
      name: AppRoutes.CART,
      page: () => CartPage(),
      // binding: CartBinding(), // ✅ cart ready in cart page
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ProfilePage(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: AppRoutes.ADD_ADDRESS,
      page: () => AddAddressPage(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      bindings: [AuthBindings(), ProductBinding()],
    ),
  ];
}
