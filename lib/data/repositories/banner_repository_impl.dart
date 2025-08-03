// data/repositories/banner_repository_impl.dart
import 'package:retoverse/data/datasources/banner_datasource.dart';
import 'package:retoverse/domain/entities/banner_entity.dart';
import 'package:retoverse/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerDataSource bannerDataSource;

  BannerRepositoryImpl(this.bannerDataSource);

  @override
  Future<List<BannerEntity>> getBanners() async {
    return await bannerDataSource.fetchBanners();
  }
}
