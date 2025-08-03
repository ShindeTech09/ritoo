import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/presentations/controllers/product_controller.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    final _products = productController.products;

    if (_products.isEmpty) {
      return Scaffold(body: Center(child: Text('No products to display')));
    }

    return Obx(
      () => Scaffold(
        appBar: AppBar(title: Text('Product List')),
        body: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (_, index) {
            debugPrint(_products[index].name);
            return ListTile(
              leading: Image.network(_products[index].images[0]),
              title: Text(_products[index].name),
            );
          },
        ),
      ),
    );
  }
}
