import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/utils/cart_tile.dart';
import 'package:retoverse/domain/entities/cart_item_entity.dart';
import 'package:retoverse/presentations/pages/cart_page/checkout_page.dart';
import '../../controllers/cart_controller.dart';
import '../../widgets/app_scaffold.dart';


class CartPage extends StatelessWidget {
  final CartController controller = Get.find<CartController>();

  CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Cart',
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(child: Text('Your cart is empty.'));
        }
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\₹${controller.totalPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return CartTile(item: item, controller: controller);
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: Obx(
        () => controller.cartItems.isEmpty
            ? SizedBox.shrink()
            : FloatingActionButton.extended(
                onPressed: () {
                  Get.to(() => CheckoutPage());
                },
                label: Text('Checkout'),
                icon: Icon(Icons.payment),
              ),
      ),
    );
  }
}
