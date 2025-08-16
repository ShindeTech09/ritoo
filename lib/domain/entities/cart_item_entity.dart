class CartItemEntity {
  final String productId;
  final String name;
  final String imageUrl;
  final double price;
  int quantity;

  CartItemEntity({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}
