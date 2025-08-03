// domain/usecases/banner_usecases/get_banners_usecase.dart
import 'package:retoverse/domain/entities/banner_entity.dart';
import 'package:retoverse/domain/repositories/banner_repository.dart';

class GetBannersUseCase {
  final BannerRepository repository;

  GetBannersUseCase(this.repository);

  Future<List<BannerEntity>> call() async {
    return await repository.getBanners();
  }
}
