import 'package:retoverse/domain/repositories/auth_repository.dart';

class PasswordResetUsecase {
  final AuthRepository repository;

  PasswordResetUsecase(this.repository);

  Future<void> call(String email) {
    return repository.sendPasswordResetEmail(email);
  }
}
