import 'package:get/get.dart';
import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/domain/repositories/product_repository.dart';

class GetProductUseCase {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  Future<RxList<ProductModel>> call() async {
    return await repository.getAllProducts();
  }
}
