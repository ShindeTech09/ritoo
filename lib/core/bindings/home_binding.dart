import 'package:get/get.dart';
import 'package:retoverse/data/datasources/banner_datasource.dart';
import 'package:retoverse/data/datasources/category_data_source.dart';
import 'package:retoverse/data/datasources/spotlight_datasource.dart';
import 'package:retoverse/data/repositories/banner_repository_impl.dart';
import 'package:retoverse/data/repositories/category_repository_impl.dart';
import 'package:retoverse/data/repositories/spotlight_repository_impl.dart';
import 'package:retoverse/domain/repositories/banner_repository.dart';
import 'package:retoverse/domain/repositories/category_repository.dart';
import 'package:retoverse/domain/repositories/spotlight_repository.dart';
import 'package:retoverse/domain/usecases/get_banner_usecase.dart';
import 'package:retoverse/domain/usecases/get_category_usecase.dart';
import 'package:retoverse/domain/usecases/get_spotlight_usecase.dart';
import 'package:retoverse/presentations/controllers/home_contoller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Data Sources
    Get.lazyPut<BannerDataSource>(() => BannerDataSource());
    Get.lazyPut<CategoryDataSource>(() => CategoryDataSource());
    Get.lazyPut<SpotlightDataSource>(() => SpotlightDataSource());

    // Repositories (bind interface to implementation)
    Get.lazyPut<BannerRepository>(() => BannerRepositoryImpl(Get.find()));
    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImpl(Get.find()));
    Get.lazyPut<SpotlightRepository>(() => SpotlightRepositoryImpl(Get.find()));

    // Use Cases
    Get.lazyPut(() => GetBannersUseCase(Get.find<BannerRepository>()));
    Get.lazyPut(() => GetCategoriesUseCase(Get.find<CategoryRepository>()));
    Get.lazyPut(() => GetSpotlightsUseCase(Get.find<SpotlightRepository>()));

    // Controller
    Get.lazyPut(() => HomeController(
          getBannersUseCase: Get.find(),
          getCategoriesUseCase: Get.find(),
          getSpotlightsUseCase: Get.find(),
        ));
  }
}