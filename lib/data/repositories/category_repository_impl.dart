// data/repositories/category_repository_impl.dart
import 'package:retoverse/data/datasources/category_data_source.dart';
import 'package:retoverse/domain/entities/category_entity.dart';
import 'package:retoverse/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource dataSource;

  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    return await dataSource.fetchCategories();
  }
}
