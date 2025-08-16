import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:retoverse/data/datasources/cart_datasource.dart';
import 'package:retoverse/data/repositories/cart_repository_impl.dart';
import 'package:retoverse/domain/repositories/cart_repository.dart';
import 'package:retoverse/presentations/controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    final user = FirebaseAuth.instance.currentUser;

    // Register DataSource — keep lazy here, it's stateless
    Get.lazyPut<CartDataSource>(() => CartDataSource());

    if (user == null) {
      // ❗ If unauthenticated, permanently register a "safe" cart controller
      Get.put<CartRepository>(
        CartRepositoryImpl(Get.find<CartDataSource>(), ''),
        permanent: true,
      );

      Get.put<CartController>(
        CartController(
          cartRepository: Get.find<CartRepository>(),
          isAuthenticated: false,
        ),
        permanent: true,
      );

      return;
    }

    // ✅ Authenticated user — register with permanent=true
    Get.put<CartRepository>(
      CartRepositoryImpl(Get.find<CartDataSource>(), user.uid),
      permanent: true,
    );

    Get.put<CartController>(
      CartController(cartRepository: Get.find<CartRepository>()),
      permanent: true,
    );
  }
}
