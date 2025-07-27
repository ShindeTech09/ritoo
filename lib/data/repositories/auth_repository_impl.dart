import 'package:firebase_auth/firebase_auth.dart';
import 'package:retoverse/data/datasources/firebase_auth_datasource.dart';
import 'package:retoverse/data/models/user_model.dart';
import 'package:retoverse/domain/entities/user_entity.dart';
import 'package:retoverse/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity> signUp(String email, String password, String name) async {
    final user = await dataSource.signUp(email, password, name);
    await dataSource.saveUserProfile(user.uid, name, email);
    return UserModel(uid: user.uid, email: email, name: name, phone: '');
  }

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final user = await dataSource.signIn(email, password);
    final data = await dataSource.getUserProfile(user.uid);
    return UserModel.fromMap(user.uid, data ?? {});
  }

  @override
  Future<void> signOut() {
    return dataSource.signOut();
  }

  @override
  Future<UserEntity> getUserProfile(String uid) async {
    final data = await dataSource.getUserProfile(uid);
    if (data == null) throw Exception("User profile not found");
    return UserModel.fromMap(uid, data);
  }

  @override
  Future<bool> isEmailVerified() {
    return dataSource.isEmailVerified();
  }

  @override
  Future<void> sendEmailVerificationMail() {
    return dataSource.sendEmailVerificationMail();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return dataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<void> updateUserProfile(UserEntity user) {
    return dataSource.updateUserProfile(
      uid: user.uid,
      name: user.name!,
      email: user.email,
      phone: user.phone ?? '',
      dob: user.dob,
      gender: user.gender ?? '',
    );
  }

  @override
  Future<User> getCurrentUser() {
    return dataSource.getCurrentUser();
  }
}
