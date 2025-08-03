import 'package:retoverse/data/datasources/product_datasource.dart';
import 'package:retoverse/domain/entities/product_entity.dart';
import 'package:retoverse/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl(this.productDataSource);

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    return await productDataSource.getAllProducts();
  }
}
