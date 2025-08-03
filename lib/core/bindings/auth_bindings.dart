import 'package:get/get.dart';
import 'package:retoverse/data/datasources/firebase_auth_datasource.dart';
import 'package:retoverse/data/repositories/auth_repository_impl.dart';
import 'package:retoverse/domain/usecases/auth_usecases/check_email_verified_usecase.dart';
import 'package:retoverse/presentations/controllers/auth_controller.dart';

import '../../domain/usecases/auth_usecases/check_session_usecase.dart';
import '../../domain/usecases/auth_usecases/edit_profile_usecase.dart';
import '../../domain/usecases/auth_usecases/get_profile_usecase.dart';
import '../../domain/usecases/auth_usecases/password_reset_usecase.dart';
import '../../domain/usecases/auth_usecases/sign_in_usecase.dart';
import '../../domain/usecases/auth_usecases/sign_out_usecase.dart';
import '../../domain/usecases/auth_usecases/sign_up_usecase.dart';
import '../../domain/usecases/auth_usecases/verify_email_usecase.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    final dataSource = FirebaseAuthDataSource();
    final repo = AuthRepositoryImpl(dataSource);

    Get.lazyPut(() => SignInUseCase(repo));
    Get.lazyPut(() => SignUpUseCase(repo));
    Get.lazyPut(() => GetUserProfileUseCase(repo));
    Get.lazyPut(() => SignOutUseCase(repo));
    Get.lazyPut(() => PasswordResetUsecase(repo));
    Get.lazyPut(() => VerifyEmailUsecase(repo));
    Get.lazyPut(() => CheckEmailVerifiedUseCase(repo));
    Get.lazyPut(() => EditProfileUseCase(repo));
    Get.lazyPut(() => CheckSessionUseCase(repo));

    Get.put(
      AuthController(
        signInUseCase: Get.find(),
        signUpUseCase: Get.find(),
        getUserProfileUseCase: Get.find(),
        signOutUseCase: Get.find(),
        passwordResetUsecase: Get.find(),
        verifyEmailUsecase: Get.find(),
        checkEmailVerifiedUseCase: Get.find(),
        editProfileUseCase: Get.find(),
        checkSessionUseCase: Get.find(),
      ),
    );
  }
}
