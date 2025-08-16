import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/domain/entities/cart_item_entity.dart';
import 'package:retoverse/domain/repositories/cart_repository.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

class CartController extends GetxController {
  final CartRepository _cartRepository;
  final bool isAuthenticated;

  CartController({
    required CartRepository cartRepository,
    this.isAuthenticated = true,
  }) : _cartRepository = cartRepository;

  final RxList<CartItemEntity> cartItems = <CartItemEntity>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load cart only if authenticated
    if (isAuthenticated) {
      loadCart();
    } else {
      cartItems.clear();
    }
  }

  Future<void> loadCart() async {
    try {
      isLoading.value = true;
      final items = await _cartRepository.getCartItems();
      cartItems.assignAll(items);
    } catch (e) {
      // Optionally log or report
    } finally {
      isLoading.value = false;
    }
  }

  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);

  Future<void> addToCart(ProductModel product, BuildContext context) async {
    if (!isAuthenticated) {
      _showSnack(context, 'Please login to add items to cart.');

      // Future.delayed(Duration(microseconds: 10));
      // Get.toNamed(AppRoutes.LOGIN);
      return;
    }
    await _cartRepository.addToCart(product);
    await loadCart();
    // debugPrint('${product.name} added to cart! & product: ${product.price}');
    // _showSnack(context, '${product.name} added to cart!');
  }

  Future<void> removeFromCart(String productId) async {
    if (!isAuthenticated) return;
    await _cartRepository.removeFromCart(productId);
    await loadCart();
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    if (!isAuthenticated) return;
    await _cartRepository.updateQuantity(productId, quantity);
    await loadCart();
  }

  Future<void> clearCart() async {
    if (!isAuthenticated) return;
    await _cartRepository.clearCart();
    await loadCart();
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  int getQuantity(String productId) {
    final item = cartItems.firstWhereOrNull(
      (item) => item.productId == productId,
    );
    return item?.quantity ?? 0;
  }
}
