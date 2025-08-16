import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/domain/repositories/product_repository.dart';

class GetProductUseCase {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  Future<List<ProductModel>> call({
    required int limit,
    bool reset = false,
  }) async {
    return await repository.getProducts(limit: limit, reset: reset);
  }
}
