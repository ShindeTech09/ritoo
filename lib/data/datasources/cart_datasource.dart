import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retoverse/data/models/cart_item_model.dart';

class CartDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CartItemModel>> fetchCart(String userId) async {
    final snapshot = await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .get();
    return snapshot.docs
        .map((doc) => CartItemModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> addToCart(String userId, CartItemModel item) async {
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(item.productId)
        .set(item.toJson(), SetOptions(merge: true));
  }

  Future<void> removeFromCart(String userId, String productId) async {
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(productId)
        .delete();
  }

  Future<void> updateQuantity(
    String userId,
    String productId,
    int quantity,
  ) async {
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(productId)
        .update({'quantity': quantity});
  }

  Future<void> clearCart(String userId) async {
    final items = await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .get();
    for (var doc in items.docs) {
      await doc.reference.delete();
    }
  }
}
