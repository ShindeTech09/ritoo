import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retoverse/data/models/product_model.dart';

class ProductDataSource {
  final _firestore = FirebaseFirestore.instance.collection('products');

  Future<List<ProductModel>> getAllProducts() async {
    final snapshot = await _firestore.get();

    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data()))
        .toList();
  }
}
