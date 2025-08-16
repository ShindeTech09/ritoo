import 'package:retoverse/data/datasources/product_datasource.dart';
import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl(this.productDataSource);

  @override
  Future<List<ProductModel>> getProducts({
    required int limit,
    bool reset = false,
  }) async {
    // If reset is true, reset pagination before fetching products
    if (reset) {
      productDataSource.resetPagination();
    }
    return await productDataSource.getProducts(limit: limit);
  }

  @override
  void resetPagination() {
    productDataSource.resetPagination();
  }

  @override
  Future<List<ProductModel>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }
}
