import 'package:retoverse/data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts({required int limit, bool reset});
  void resetPagination();
}
