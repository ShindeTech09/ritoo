import 'package:get/get.dart';
import 'package:retoverse/data/datasources/product_datasource.dart';
import 'package:retoverse/data/repositories/product_repository_impl.dart';
import 'package:retoverse/domain/usecases/product_usecases/get_product_usecase.dart';
import 'package:retoverse/presentations/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    // Data Source
    Get.lazyPut<ProductDataSource>(() => ProductDataSource());

    // Repository
    Get.lazyPut<ProductRepositoryImpl>(
      () => ProductRepositoryImpl(Get.find<ProductDataSource>()),
    );

    // UseCase
    Get.lazyPut<GetProductUseCase>(
      () => GetProductUseCase(Get.find<ProductRepositoryImpl>()),
    );

    // Controller
    Get.put<ProductController>(ProductController(), permanent: true);
    ;
  }
}
