import 'package:retoverse/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.phone,
    super.dob,
    super.gender,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'],
      gender: data['gender'],
      dob: data['dob'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      if (gender != null) 'gender': gender,
      if (dob != null) 'dob': dob,
    };
  }
}
