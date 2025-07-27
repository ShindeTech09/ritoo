import 'package:retoverse/domain/entities/user_entity.dart';
import 'package:retoverse/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserEntity> call(String email, String password, String name) {
    return repository.signUp(email, password, name);
  }
}
