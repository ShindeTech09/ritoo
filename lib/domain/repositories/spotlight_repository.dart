// domain/repositories/spotlight_repository.dart
import 'package:retoverse/domain/entities/spotlight_entity.dart';

abstract class SpotlightRepository {
  Future<List<SpotlightEntity>> getSpotlights();
}
