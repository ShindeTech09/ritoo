// domain/repositories/category_repository.dart
import 'package:retoverse/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getCategories();
}
