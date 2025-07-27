import 'package:firebase_auth/firebase_auth.dart';
import 'package:retoverse/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signUp(String email, String password, String name);
  Future<UserEntity> signIn(String email, String password);
  Future<UserEntity> getUserProfile(String uid);
  Future<User> getCurrentUser();
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> sendEmailVerificationMail();
  Future<bool> isEmailVerified();
  Future<void> updateUserProfile(UserEntity updateUser);
}
