import 'package:retoverse/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;
  SignOutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}
