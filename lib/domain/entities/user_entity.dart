class UserEntity {
  final String uid;
  final String email;
  final String? name;
  final String? phone;
  final String? gender;
  final String? dob;

  UserEntity({
    required this.uid,
    required this.email,
    this.name,
    this.phone,
    this.gender,
    this.dob,
  });
}
