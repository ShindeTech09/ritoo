// data/datasources/banner_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retoverse/data/models/banner_model.dart';

class BannerDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners() async {
    final snapshot = await _firestore.collection('banners').get();
    return snapshot.docs
        .map((doc) => BannerModel.fromJson(doc.data()))
        .toList();
  }
}
