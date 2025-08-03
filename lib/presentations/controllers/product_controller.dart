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
    super.onInit();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    isLoading.value = true;
    try {
      final result = await getProductUseCase();
      products.assignAll(result);
    } catch (e) {
      // Handle error gracefully
      Get.snackbar('Error', 'Failed to load products due to ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
