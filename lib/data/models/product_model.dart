import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retoverse/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.categoryId,
    required super.brand,
    required super.sizes,
    required super.colors,
    required super.stock,
    required super.rating,
    required super.images,
    required super.isFeatured,
    required super.createdAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      categoryId: map['categoryId'] ?? '',
      brand: map['brand'] ?? '',
      sizes: List<String>.from(map['sizes'] ?? []),
      colors: List<String>.from(map['colors'] ?? []),
      stock: map['stock'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      images: map['images'] ?? '',
      isFeatured: map['isFeatured'] ?? false,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'brand': brand,
      'sizes': sizes,
      'colors': colors,
      'stock': stock,
      'rating': rating,
      'images': images,
      'isFeatured': isFeatured,
      'createdAt': createdAt,
    };
  }
}
