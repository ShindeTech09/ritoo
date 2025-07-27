import 'package:retoverse/domain/entities/user_entity.dart';
import 'package:retoverse/domain/repositories/auth_repository.dart';

class GetUserProfileUseCase {
  final AuthRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<UserEntity> call(String uid) {
    return repository.getUserProfile(uid);
  }
}
