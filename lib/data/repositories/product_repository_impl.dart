import 'package:get/get.dart';
import 'package:retoverse/data/datasources/product_datasource.dart';
import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl(this.productDataSource);

  @override
  Future<RxList<ProductModel>> getAllProducts() async {
    return await productDataSource.getAllProducts();
  }
}
