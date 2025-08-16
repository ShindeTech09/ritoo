import 'package:get/get.dart';
import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/data/repositories/product_repository_impl.dart';

class ProductController extends GetxController {
  final ProductRepositoryImpl _repository = ProductRepositoryImpl(Get.find());

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool hasMore = true.obs;
  RxString errorMessage = ''.obs;
  RxString searchQuery = ''.obs;
  RxString sortBy = 'newest'.obs;
  RxString selectedCategory = 'All'.obs;
  final int _limit = 10;

  @override
  void onInit() {
    super.onInit();
    loadInitialProducts();
    debounce(
      searchQuery,
      (_) => _applyFiltersAndSearch(),
      time: Duration(milliseconds: 500),
    );
  }

  Future<void> loadInitialProducts() async {
    if (isLoading.value) return;
    isLoading.value = true;
    errorMessage.value = '';
    products.clear();
    filteredProducts.clear();
    hasMore.value = true;
    _repository.resetPagination();

    try {
      final result = await _repository.getProducts(limit: _limit, reset: true);
      products.assignAll(result);
      filteredProducts.assignAll(result);
      hasMore.value = result.length == _limit;
      _sortProducts();
    } catch (e) {
      errorMessage.value = 'Failed to load products: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    if (isLoading.value || isLoadingMore.value || !hasMore.value) return;
    isLoadingMore.value = true;

    try {
      final result = await _repository.getProducts(limit: _limit);
      if (result.isEmpty) {
        hasMore.value = false;
      } else {
        products.addAll(result);
        _applyFiltersAndSearch();
        hasMore.value = result.length == _limit;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load more products: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshProducts() async {
    await loadInitialProducts();
  }

  void searchProducts(String query) {
    searchQuery.value = query;
  }

  void sortProducts(String sortType) {
    sortBy.value = sortType;
    _sortProducts();
  }

  void _sortProducts() {
    switch (sortBy.value) {
      case 'price_asc':
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_desc':
        filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'newest':
      default:
        filteredProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }
    filteredProducts.refresh();
  }

  void _applyFiltersAndSearch() {
    if (searchQuery.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      final query = searchQuery.value.toLowerCase();
      filteredProducts.assignAll(
        products.where(
          (product) =>
              product.name.toLowerCase().contains(query) ||
              product.description.toLowerCase().contains(query),
        ),
      );
    }
    _sortProducts();
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (category == 'All') {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
        products.where((p) => p.categoryId == category).toList(),
      );
    }
  }
}
