// data/models/spotlight_model.dart
import 'package:retoverse/domain/entities/spotlight_entity.dart';

class SpotlightModel extends SpotlightEntity {
  SpotlightModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.productId,
  });

  factory SpotlightModel.fromJson(Map<String, dynamic> json) {
    return SpotlightModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      productId: json['productId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'productId': productId,
    };
  }
}
