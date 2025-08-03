import 'package:get/get.dart';
import 'package:retoverse/data/models/product_model.dart';

abstract class ProductRepository {
  Future<RxList<ProductModel>> getAllProducts();
}
