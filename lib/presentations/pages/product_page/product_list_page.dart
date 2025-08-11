/*
class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    if (productController.products.isEmpty) {
      return Scaffold(body: Center(child: Text('No products to display')));
    }

    return Obx(() {
      return Scaffold(
        appBar: AppBar(title: Text('Product List')),
        body: ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (_, index) {
            final product = productController.products[index];
            return ListTile(
              leading: Image.network(product.images),
              title: Text(product.name),
            );
          },
        ),
      );
    });
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/utils/responsive_widget.dart';

import '../../controllers/product_controller.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: _productList(context, controller),
      desktop: _productList(context, controller),
    );
  }
}

Widget _productList(BuildContext context, ProductController controller) {
  return Scaffold(
    appBar: AppBar(title: Text('Product List')),
    body: Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      } else {
        return GridView.builder(
          itemCount: controller.products.length,
          itemBuilder: (_, index) {
            var product = controller.products[index];
            return GridTile(
              // leading: Image.network(
              //   product.images,
              //   width: 50,
              //   height: 50,
              //   fit: BoxFit.cover,
              // ),
              header: Text(
                product.name,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              footer: Center(child: Text(product.price.toString())),
              child: SizedBox(
                child: Image(
                  image: NetworkImage(product.images),
                  height: 30,
                  width: 30,
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
        );
      }
    }),
  );
}
