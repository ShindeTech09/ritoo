import 'package:retoverse/domain/entities/user_entity.dart';
import 'package:retoverse/domain/repositories/auth_repository.dart';

class CheckSessionUseCase {
  final AuthRepository repository;

  CheckSessionUseCase(this.repository);

  Future<UserEntity?> call() async {
      final currentUser = await repository.getCurrentUser();
      return await repository.getUserProfile(currentUser.uid);
  }
}
