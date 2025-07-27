import 'package:retoverse/domain/repositories/auth_repository.dart';

class VerifyEmailUsecase {
  final AuthRepository repository;

  VerifyEmailUsecase(this.repository);

  Future<void> call() {
    return repository.sendEmailVerificationMail();
  }
}
