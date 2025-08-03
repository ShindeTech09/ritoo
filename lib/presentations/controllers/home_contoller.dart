// presentations/controllers/home_controller.dart
import 'package:get/get.dart';
import 'package:retoverse/domain/entities/banner_entity.dart';
import 'package:retoverse/domain/entities/category_entity.dart';
import 'package:retoverse/domain/entities/spotlight_entity.dart';
import 'package:retoverse/domain/usecases/get_banner_usecase.dart';
import 'package:retoverse/domain/usecases/get_category_usecase.dart';
import 'package:retoverse/domain/usecases/get_spotlight_usecase.dart';

class HomeController extends GetxController {
  final GetBannersUseCase getBannersUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetSpotlightsUseCase getSpotlightsUseCase;

  HomeController({
    required this.getBannersUseCase,
    required this.getCategoriesUseCase,
    required this.getSpotlightsUseCase,
  });

  final RxList<BannerEntity> banners = <BannerEntity>[].obs;
  final RxBool isBannerLoading = false.obs;
  final RxList<CategoryEntity> categories = <CategoryEntity>[].obs;
  final RxBool isCategoryLoading = false.obs;
  final RxList<SpotlightEntity> spotlights = <SpotlightEntity>[].obs;
  final RxBool isSpotlightLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    Future.microtask(() {
      _loadBanners();
      _loadCategories();
      _loadSpotlights();
    });
  }

  Future<void> _loadBanners() async {
    isBannerLoading.value = true;
    try {
      final result = await getBannersUseCase();
      banners.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", "Failed to load banners: ${e.toString()}");
    } finally {
      isBannerLoading.value = false;
    }
  }

  Future<void> _loadCategories() async {
    isCategoryLoading.value = true;
    try {
      final result = await getCategoriesUseCase();
      categories.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", "Failed to load categories: ${e.toString()}");
    } finally {
      isCategoryLoading.value = false;
    }
  }

  Future<void> _loadSpotlights() async {
    isSpotlightLoading.value = true;
    try {
      final result = await getSpotlightsUseCase();
      spotlights.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", "Failed to load spotlights: ${e.toString()}");
    } finally {
      isSpotlightLoading.value = false;
    }
  }
}
