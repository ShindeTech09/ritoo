/*
class ProductController extends GetxController {
  final GetProductUseCase getProductUseCase;

  ProductController({required this.getProductUseCase});

  late RxList<ProductModel> products = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    isLoading.value = true;
    try {
      products = await getProductUseCase();
    } catch (e) {
      // Handle error gracefully
      Get.snackbar('Error', 'Failed to load products due to ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
*/

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:retoverse/domain/entities/product_entity.dart';
import 'package:retoverse/domain/usecases/product_usecases/get_product_usecase.dart';

class ProductController extends GetxController {
  final GetProductUseCase getProductUseCase;

  ProductController({required this.getProductUseCase});

  final RxList<ProductEntity> products = <ProductEntity>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;

    try {
      final result = await getProductUseCase();
      products.assignAll(result);
      debugPrint(
        'vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv${products.length.toString()}',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load products in controller ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
