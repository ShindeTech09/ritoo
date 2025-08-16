import 'package:retoverse/presentations/pages/cart_page/address.dart';

class UserEntity {
  final String uid;
  final String email;
  final String? name;
  final String? phone;
  final String? gender;
  final String? dob;
  final List<Address> addresses;
  final int points; // <-- Added points field

  UserEntity({
    required this.uid,
    required this.email,
    this.name,
    this.phone,
    this.gender,
    this.dob,
    this.addresses = const [],
    this.points = 0, // <-- Default value
  });
}
