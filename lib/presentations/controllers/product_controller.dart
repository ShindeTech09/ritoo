import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/domain/usecases/product_usecases/get_product_usecase.dart';

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
      // products.addAll(result);
      debugPrint(products[0].name);
    } catch (e) {
      // Handle error gracefully
      Get.snackbar('Error', 'Failed to load products due to ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
