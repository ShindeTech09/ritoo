class ProductEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final String brand;
  final List<String> sizes;
  final List<String> colors;
  final int stock;
  final double rating;
  final String images;
  final bool isFeatured;
  final DateTime createdAt;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.brand,
    required this.sizes,
    required this.colors,
    required this.stock,
    required this.rating,
    required this.images,
    required this.isFeatured,
    required this.createdAt,
  });
}
