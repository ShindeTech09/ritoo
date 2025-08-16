import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/utils/responsive_widget.dart';
import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/presentations/controllers/cart_controller.dart';
import 'package:retoverse/presentations/widgets/app_scaffold.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: _buildVerticalLayout(context),
      desktop: _buildHorizontalLayout(context),
    );
  }

  Widget _buildVerticalLayout(BuildContext context) {
    return AppScaffold(
      title: product.name,
      customAppBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _shareProduct),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            const SizedBox(height: 16),
            _buildProductInfo(context),
            const SizedBox(height: 24),
            _buildProductDetails(context),
            const SizedBox(height: 32),
            _buildBottomBar(context),
          ],
        ),
      ),
      showCartIcon: true,
      showProfileIcon: true,
    );
  }

  Widget _buildHorizontalLayout(BuildContext context) {
    return AppScaffold(
      title: product.name,
      customAppBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _shareProduct),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: _buildProductImage()),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProductInfo(context),
                          const SizedBox(height: 24),
                          _buildProductDetails(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: _buildBottomBar(context),
          ),
        ],
      ),
      showCartIcon: true,
      showProfileIcon: true,
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: product.images is List && product.images.isNotEmpty
              ? Image.network(
                  product.images,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, size: 64),
                  ),
                )
              : product.images.isNotEmpty
              ? Image.network(
                  product.images,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, size: 64),
                  ),
                )
              : Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, size: 64),
                ),
        ),
        if (product.isFeatured)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'FEATURED',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (product.brand.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  product.brand.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            RatingBarIndicator(
              rating: product.rating,
              itemBuilder: (context, index) =>
                  const Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 20,
              unratedColor: Colors.amber.withAlpha(50),
            ),
            const SizedBox(width: 8),
            Text(
              product.rating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Rs${product.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.green[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        if (product.stock <= 5 && product.stock > 0)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Only ${product.stock} left in stock!',
              style: TextStyle(
                color: Colors.orange[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (product.stock == 0)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Out of stock',
              style: TextStyle(
                color: Colors.red[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        const SizedBox(height: 16),
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
        ),
      ],
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (product.categoryId.isNotEmpty)
          _buildDetailRow('Category', product.categoryId),
        if (product.sizes.isNotEmpty)
          _buildDetailRow('Available Sizes', product.sizes.join(', ')),
        if (product.colors.isNotEmpty)
          _buildDetailRow('Available Colors', product.colors.join(', ')),
        _buildDetailRow('Product ID', product.id),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Row(
      children: [
        if (product.stock > 0) ...[
          Expanded(
            child: Obx(() {
              int quantity = cartController.getQuantity(product.id);
              if (quantity == 0) {
                return ElevatedButton.icon(
                  onPressed: () {
                    cartController.addToCart(product, context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Add to Cart'),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.08),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            cartController.updateQuantity(
                              product.id,
                              quantity - 1,
                            );
                          } else {
                            cartController.removeFromCart(product.id);
                          }
                        },
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (quantity < product.stock) {
                            cartController.updateQuantity(
                              product.id,
                              quantity + 1,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              }
            }),
          ),
          const SizedBox(width: 16),
        ],
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              product.stock > 0 ? 'Buy Now' : 'Notify Me',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _shareProduct() {
    // Implement share functionality
  }
}
