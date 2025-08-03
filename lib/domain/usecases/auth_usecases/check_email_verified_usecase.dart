import 'package:retoverse/domain/repositories/auth_repository.dart';

class CheckEmailVerifiedUseCase {
  final AuthRepository repository;

  CheckEmailVerifiedUseCase(this.repository);

  Future<bool> call() async {
    return repository.isEmailVerified();
  }
}
