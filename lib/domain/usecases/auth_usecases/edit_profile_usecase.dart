import 'package:retoverse/domain/entities/user_entity.dart';
import 'package:retoverse/domain/repositories/auth_repository.dart';

class EditProfileUseCase {
  final AuthRepository repository;

  EditProfileUseCase(this.repository);

  Future<void> call(UserEntity user) async {
    await repository.updateUserProfile(user);
  }
}
