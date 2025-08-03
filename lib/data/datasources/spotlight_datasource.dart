// data/datasources/spotlight_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retoverse/data/models/spotlight_model.dart';

class SpotlightDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<SpotlightModel>> fetchSpotlights() async {
    final snapshot = await _firestore.collection('spotlights').get();
    return snapshot.docs.map((doc) => SpotlightModel.fromJson(doc.data())).toList();
  }
}
