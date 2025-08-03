// data/models/banner_model.dart
import 'package:retoverse/domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  BannerModel({
    required super.id,
    required super.imageUrl,
    required super.redirectUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      redirectUrl: json['redirectUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'imageUrl': imageUrl, 'redirectUrl': redirectUrl};
  }
}
