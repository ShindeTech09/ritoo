import 'package:retoverse/data/models/product_model.dart';
import 'package:retoverse/domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required super.productId,
    required super.name,
    required super.imageUrl,
    required super.price,
    required super.quantity,
  });

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      productId: entity.productId,
      name: entity.name,
      imageUrl: entity.imageUrl,
      price: entity.price,
      quantity: entity.quantity,
    );
  }

  factory CartItemModel.fromProductEntity(ProductModel product, int quantity) {
    return CartItemModel(
      productId: product.id,
      name: product.name,
      imageUrl: product.images,
      price: product.price,
      quantity: quantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'name': name,
    'imageUrl': imageUrl,
    'price': price,
    'quantity': quantity,
  };
}
