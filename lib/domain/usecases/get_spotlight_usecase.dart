// domain/usecases/spotlight_usecases/get_spotlights_usecase.dart
import 'package:retoverse/domain/entities/spotlight_entity.dart';
import 'package:retoverse/domain/repositories/spotlight_repository.dart';

class GetSpotlightsUseCase {
  final SpotlightRepository repository;

  GetSpotlightsUseCase(this.repository);

  Future<List<SpotlightEntity>> call() async {
    return await repository.getSpotlights();
  }
}
