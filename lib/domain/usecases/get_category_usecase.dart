// domain/usecases/category_usecases/get_categories_usecase.dart
import 'package:retoverse/domain/entities/category_entity.dart';
import 'package:retoverse/domain/repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call() async {
    return await repository.getCategories();
  }
}
