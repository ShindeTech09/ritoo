import 'package:retoverse/domain/entities/cart_item_entity.dart';
import 'package:retoverse/domain/entities/product_entity.dart';
import 'package:retoverse/domain/repositories/cart_repository.dart';
import 'package:retoverse/data/datasources/cart_datasource.dart';
import 'package:retoverse/data/models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource _dataSource;
  final String userId;

  CartRepositoryImpl(this._dataSource, this.userId);

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    return await _dataSource.fetchCart(userId);
  }

  @override
  Future<void> addToCart(ProductEntity product) async {
    final item = CartItemModel(
      productId: product.id,
      name: product.name,
      imageUrl: product.images,
      price: product.price,
      quantity: 1,
    );
    await _dataSource.addToCart(userId, item);
  }

  @override
  Future<void> removeFromCart(String productId) async {
    await _dataSource.removeFromCart(userId, productId);
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) async {
    await _dataSource.updateQuantity(userId, productId, quantity);
  }

  @override
  Future<void> clearCart() async {
    await _dataSource.clearCart(userId);
  }
}
