/*

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/utils/responsive_widget.dart';
import 'package:retoverse/presentations/controllers/product_controller.dart';
import 'package:retoverse/presentations/pages/product_page/product_detail_page.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/utils/product_card.dart';
import '../../../data/models/product_model.dart';
import 'package:retoverse/presentations/widgets/app_scaffold.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Products',
      body: GetBuilder<ProductController>(
        init: ProductController(getProductUseCase: Get.find()),
        builder: (controller) => ResponsiveWidget(
          mobile: _buildProductGrid(context, controller, crossAxisCount: 2),
          desktop: _buildProductGrid(context, controller, crossAxisCount: 4),
        ),
      ),
      showCartIcon: true,
      showProfileIcon: true,
    );
  }

  Widget _buildProductGrid(
    BuildContext context,
    ProductController controller, {
    required int crossAxisCount,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: controller.refreshProducts,
          ),
        ],
      ),
      body: Obx(() => _buildProductBody(context, controller, crossAxisCount)),
    );
  }

  Widget _buildProductBody(
    BuildContext context,
    ProductController controller,
    int crossAxisCount,
  ) {
    if (controller.isLoading.value && controller.products.isEmpty) {
      return _buildLoadingGrid(crossAxisCount);
    }

    if (controller.products.isEmpty) {
      return Center(child: Text('No products found'));
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.pixels >=
                notification.metrics.maxScrollExtent * 0.8 &&
            controller.hasMore.value &&
            !controller.isLoading.value) {
          controller.loadMoreProducts();
        }
        return false;
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          final product = controller.products[index];
          return ProductCard(
            product: product,
            onPressed: () => _navigateToProductDetail(context, product),
          );
        },
      ),
    );
  }

  Widget _buildLoadingGrid(int crossAxisCount) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _navigateToProductDetail(BuildContext context, ProductModel product) {
    Get.to(() => ProductDetailPage(product: product));
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/utils/product_card.dart';
import 'package:retoverse/core/utils/responsive_widget.dart';
import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/presentations/controllers/product_controller.dart';
import 'package:retoverse/presentations/pages/product_page/product_detail_page.dart';
import 'package:retoverse/presentations/widgets/app_scaffold.dart';
import 'package:shimmer/shimmer.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Discover Products',
      body: GetBuilder<ProductController>(
        init: ProductController(),
        builder: (controller) => Column(
          children: [
            _buildSearchAndFilter(controller),
            Expanded(
              child: ResponsiveWidget(
                mobile: _buildProductGrid(
                  context,
                  controller,
                  crossAxisCount: 2,
                ),

                desktop: _buildProductGrid(
                  context,
                  controller,
                  crossAxisCount: 4,
                ),
              ),
            ),
          ],
        ),
      ),
      showCartIcon: true,
      showProfileIcon: true,
    );
  }

  Widget _buildSearchAndFilter(ProductController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                controller.searchProducts(value);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () => _showFilterBottomSheet(controller),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(
    BuildContext context,
    ProductController controller, {
    required int crossAxisCount,
  }) {
    return Obx(() => _buildProductBody(context, controller, crossAxisCount));
  }

  Widget _buildProductBody(
    BuildContext context,
    ProductController controller,
    int crossAxisCount,
  ) {
    if (controller.isLoading.value && controller.products.isEmpty) {
      return _buildLoadingGrid(crossAxisCount);
    }

    if (controller.products.isEmpty) {
      return _buildEmptyState(controller);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await controller.refreshProducts();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent * 0.8 &&
              controller.hasMore.value &&
              !controller.isLoading.value) {
            controller.loadMoreProducts();
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = controller.products[index];
                  return ProductCard(
                    product: product,
                    onTap: () => _navigateToProductDetail(context, product),
                  );
                }, childCount: controller.products.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
              ),
            ),
            if (controller.isLoadingMore.value)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ProductController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_state.png', height: 150, width: 150),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: Get.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filter',
            style: Get.textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.refreshProducts,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingGrid(int crossAxisCount) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToProductDetail(BuildContext context, ProductModel product) {
    Get.to(
      () => ProductDetailPage(product: product),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _showFilterBottomSheet(ProductController controller) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Filter Products',
              style: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFilterOption(
              'Price: Low to High',
              controller.sortBy == 'price_asc',
              () => controller.sortProducts('price_asc'),
            ),
            _buildFilterOption(
              'Price: High to Low',
              controller.sortBy == 'price_desc',
              () => controller.sortProducts('price_desc'),
            ),
            _buildFilterOption(
              'Newest First',
              controller.sortBy == 'newest',
              () => controller.sortProducts('newest'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String title, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? Get.theme.primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? Get.theme.primaryColor
                  : Colors.grey.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? Get.theme.primaryColor : Colors.grey,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Get.textTheme.bodyLarge?.copyWith(
                  color: isSelected ? Get.theme.primaryColor : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
