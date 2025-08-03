// data/repositories/spotlight_repository_impl.dart
import 'package:retoverse/data/datasources/spotlight_datasource.dart';
import 'package:retoverse/domain/entities/spotlight_entity.dart';
import 'package:retoverse/domain/repositories/spotlight_repository.dart';

class SpotlightRepositoryImpl implements SpotlightRepository {
  final SpotlightDataSource dataSource;

  SpotlightRepositoryImpl(this.dataSource);

  @override
  Future<List<SpotlightEntity>> getSpotlights() async {
    return await dataSource.fetchSpotlights();
  }
}
