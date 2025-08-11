import 'package:retoverse/data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getAllProducts();
}
