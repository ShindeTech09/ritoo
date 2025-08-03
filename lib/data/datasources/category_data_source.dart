// data/datasources/category_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retoverse/data/models/category_mode.dart';

class CategoryDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> fetchCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    return snapshot.docs.map((doc) => CategoryModel.fromJson(doc.data())).toList();
  }
}
