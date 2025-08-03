// domain/repositories/banner_repository.dart
import 'package:retoverse/domain/entities/banner_entity.dart';

abstract class BannerRepository {
  Future<List<BannerEntity>> getBanners();
}
