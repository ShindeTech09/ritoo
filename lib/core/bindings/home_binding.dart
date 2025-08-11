import 'package:get/get.dart';
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
    // Use Cases
    Get.lazyPut(() => GetBannersUseCase(Get.find<BannerRepository>()));
    Get.lazyPut(() => GetCategoriesUseCase(Get.find<CategoryRepository>()));
    Get.lazyPut(() => GetSpotlightsUseCase(Get.find<SpotlightRepository>()));

    // Controller
    Get.lazyPut(
      () => HomeController(
        getBannersUseCase: Get.find(),
        getCategoriesUseCase: Get.find(),
        getSpotlightsUseCase: Get.find(),
      ),
    );
  }
}
