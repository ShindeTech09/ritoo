import 'package:retoverse/domain/entities/user_entity.dart';
import 'package:retoverse/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<UserEntity> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
