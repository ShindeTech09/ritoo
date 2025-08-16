import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/presentations/pages/product_page/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool isHorizontal;
  final bool showPrice;
  final Function()? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.isHorizontal = false,
    this.showPrice = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = (product.images is List && product.images.isNotEmpty)
        ? product.images
        : (product.images is String ? product.images : '');

    // 🔹 Horizontal Card → slightly bigger
    if (isHorizontal) {
      return GestureDetector(
        onTap: onTap ?? () => Get.to(() => ProductDetailPage(product: product)),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: 150, // ⬆️ increased size
            child: Row(
              children: [
                _buildImage(imageUrl.toString(), height: 200, width: 140),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _buildInfo(context, compact: true),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // 🔹 Vertical Card → slightly smaller
    return GestureDetector(
      onTap: onTap ?? () => Get.to(() => ProductDetailPage(product: product)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(
              imageUrl.toString(),
              height: 100,
              width: double.infinity,
            ), // ⬇️ reduced size
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildInfo(context, compact: false),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- IMAGE ----------
  Widget _buildImage(
    String url, {
    required double height,
    required double width,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: url.isNotEmpty
          ? Image.network(
              url,
              height: height,
              width: width,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                height: height,
                width: width,
                color: Colors.grey[200],
                child: Icon(Icons.broken_image, size: height * 0.4),
              ),
            )
          : Container(
              height: height,
              width: width,
              color: Colors.grey[200],
              child: Icon(Icons.image, size: height * 0.4),
            ),
    );
  }

  /// ---------- INFO ----------
  Widget _buildInfo(BuildContext context, {bool compact = false}) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Product Name
        Text(
          product.name,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: compact ? 15 : 16,
          ),
          maxLines: compact ? 1 : 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),

        // Brand
        Text(
          product.brand,
          style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),

        // Price + Discount
        showPrice
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '₹${product.price.toStringAsFixed(2)}',
                    style: textTheme.titleSmall?.copyWith(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                      fontSize: compact ? 14 : 15,
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (product.discount > 0) ...[
                    Text(
                      '₹${(product.price / (1 - product.discount / 100)).toStringAsFixed(2)}',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontSize: compact ? 11 : 12,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '-${product.discount.toInt()}%',
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: compact ? 11 : 12,
                        ),
                      ),
                    ),
                  ],
                ],
              )
            : SizedBox.shrink(),
        const SizedBox(height: 6),

        // Rating
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: compact ? 14 : 16),
            const SizedBox(width: 4),
            Text(
              product.rating.toStringAsFixed(1),
              style: textTheme.bodySmall?.copyWith(
                color: Colors.grey[700],
                fontSize: compact ? 12 : 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
