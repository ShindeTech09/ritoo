import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/utils/footer_widget.dart';
import 'package:retoverse/core/utils/product_card.dart';
import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/presentations/controllers/product_controller.dart';
import 'package:retoverse/presentations/pages/product_page/product_detail_page.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';
import 'package:retoverse/presentations/widgets/app_scaffold.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: '',
      showAppBar: true,
      showCartIcon: true,
      showProfileIcon: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSearchDialog(context),
        tooltip: 'Search Products',
        child: const Icon(Icons.search),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final products = productController.filteredProducts;
        if (products.isEmpty) {
          return const Center(child: Text('No products available.'));
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPromoCarousel(),
              _buildCategoryChips(),
              _buildSectionHeader('Featured Products'),
              _buildFeaturedProducts(products),
              _buildSectionHeader('Special Offers'),
              _buildSpecialOffers(products),
              _buildSectionHeader('New Arrivals'),
              _buildNewArrivals(products),
              FooterWidget(),
            ],
          ),
        );
      }),
    );
  }

  void showSearchDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Products'),
        content: TextField(
          controller: searchController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter product name'),
          onSubmitted: (query) {
            productController.searchProducts(query);
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              productController.searchProducts(searchController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCarousel() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.purple.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Summer Sale ${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Up to 50% off',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('Shop Now'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = [
      'All',
      'Electronics',
      'Fashion',
      'Home',
      'Beauty',
      'Sports',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(categories[index]),
                selected:
                    productController.selectedCategory.value ==
                    categories[index],
                selectedColor: Colors.blue.shade400,
                labelStyle: TextStyle(
                  color:
                      productController.selectedCategory.value ==
                          categories[index]
                      ? Colors.white
                      : Colors.black,
                ),
                onSelected: (selected) {
                  if (selected) {
                    productController.filterByCategory(categories[index]);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.PRODUCT_LIST);
            },
            child: const Text('View All'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProducts(List<ProductModel> products) {
    final featured = products.where((p) => p.isFeatured).toList();
    if (featured.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No featured products.'),
      );
    }
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: featured.length,
        itemBuilder: (context, index) {
          final product = featured[index];
          return SizedBox(
            width: 200,
            height: 400,
            child: ProductCard(
              product: product,
              showPrice: false,
              onTap: () => _navigateToProductDetail(context, product),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpecialOffers(List<ProductModel> products) {
    final offers = products.where((p) => p.discount > 0).toList();
    if (offers.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No special offers.'),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(), // ✅ prevent scroll conflict
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final product = offers[index];
          return ProductCard(
            product: product,
            onTap: () => _navigateToProductDetail(context, product),
          );
        },
      ),
    );
  }

  Widget _buildNewArrivals(List<ProductModel> products) {
    final arrivals = products.take(3).toList();
    if (arrivals.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No new arrivals.'),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        shrinkWrap: true, // ✅ important
        physics:
            const NeverScrollableScrollPhysics(), // ✅ prevent scroll conflict
        itemCount: arrivals.length,
        itemBuilder: (context, index) {
          final product = arrivals[index];
          return ProductCard(
            product: product,
            isHorizontal: true,
            onTap: () => _navigateToProductDetail(context, product),
          );
        },
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
}
