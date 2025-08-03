import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/presentations/controllers/product_controller.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});
  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    final _products = productController.products;
    return Scaffold(
      appBar: AppBar(title: Text('Product List')),
      body: ListView.builder(
        itemCount: productController.products.length,

        itemBuilder: (_, index) {
          return ListTile(leading: Image.network(_products[index].images[0]));
        },
      ),
    );
  }
}
