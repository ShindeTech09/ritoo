import 'package:retoverse/domain/entities/product_entity.dart';
import 'package:retoverse/domain/repositories/product_repository.dart';

class GetProductUseCase {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getAllProducts();
  }
}
