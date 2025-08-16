import 'package:get/get.dart';
import 'package:retoverse/data/datasources/firebase_auth_datasource.dart';
import 'package:retoverse/domain/entities/user_entity.dart';
import 'package:retoverse/domain/repositories/cart_repository.dart';
import 'package:retoverse/domain/usecases/auth_usecases/check_email_verified_usecase.dart';
import 'package:retoverse/presentations/controllers/cart_controller.dart';
import 'package:retoverse/presentations/pages/cart_page/address.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

import '../../domain/usecases/auth_usecases/check_session_usecase.dart';
import '../../domain/usecases/auth_usecases/edit_profile_usecase.dart';
import '../../domain/usecases/auth_usecases/get_profile_usecase.dart';
import '../../domain/usecases/auth_usecases/password_reset_usecase.dart';
import '../../domain/usecases/auth_usecases/sign_in_usecase.dart';
import '../../domain/usecases/auth_usecases/sign_out_usecase.dart';
import '../../domain/usecases/auth_usecases/sign_up_usecase.dart';
import '../../domain/usecases/auth_usecases/verify_email_usecase.dart';

class AuthController extends GetxController {
  late final SignInUseCase signInUseCase;
  late final SignUpUseCase signUpUseCase;
  late final GetUserProfileUseCase getUserProfileUseCase;
  late final SignOutUseCase signOutUseCase;
  late final PasswordResetUsecase passwordResetUsecase;
  late final VerifyEmailUsecase verifyEmailUsecase;
  late final CheckEmailVerifiedUseCase checkEmailVerifiedUseCase;
  late final EditProfileUseCase editProfileUseCase;
  late final CheckSessionUseCase checkSessionUseCase;
  final Rxn<UserEntity> currentUser = Rxn<UserEntity>();
  final FirebaseAuthDataSource _authDataSource = FirebaseAuthDataSource();
  final RxList<Address> addresses = <Address>[].obs;

  AuthController({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getUserProfileUseCase,
    required this.signOutUseCase,
    required this.passwordResetUsecase,
    required this.verifyEmailUsecase,
    required this.checkEmailVerifiedUseCase,
    required this.editProfileUseCase,
    required this.checkSessionUseCase,
  });

  Future<void> register(String email, String password, String name) async {
    try {
      final user = await signUpUseCase(email, password, name);
      currentUser.value = user;
      await verifyEmail();
      Get.snackbar(
        'Success',
        'Account created successfully. Please verify email from your inbox.',
      );
      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final user = await signInUseCase(email, password);
      currentUser.value = user;
      final isVerified = await checkEmailVerifiedUseCase();
      if (!isVerified) {
        await verifyEmail();
        await logout();
        Get.snackbar(
          'Email Not Verified',
          'Please verify your email before logging in.',
        );
        return;
      }
      // Store userId locally for cart binding or other features
      final userId = user.uid;
      Get.put<String>(userId, tag: 'userId');
      await loadAddressesFromBackend();

      // Register CartController with isAuthenticated: true
      final cartRepository = Get.find<CartRepository>();
      if (Get.isRegistered<CartController>()) {
        Get.delete<CartController>();
      }
      Get.put(
        CartController(cartRepository: cartRepository, isAuthenticated: true),
      );

      // Proceed with navigation or other logic
      // e.g., Get.offAllNamed(AppRoutes.HOME);
      Get.snackbar('Success', 'Logged in');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await signOutUseCase();
      currentUser.value = null;
      Get.snackbar('Successful', 'Logged out Successfully');
    } catch (e) {
      Get.snackbar('Error ', 'Logout failed due to ${e.toString()}');
    }
    if (Get.isRegistered<CartController>()) {
      Get.delete<CartController>();
    }
    final cartRepository = Get.find<CartRepository>();
    Get.put(
      CartController(cartRepository: cartRepository, isAuthenticated: false),
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await passwordResetUsecase(email);
      Get.snackbar('Success', 'Reset Link Sent to Email. Please verify');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Verification mail send failed due to ${e.toString()}',
      );
    }
  }

  Future<void> verifyEmail() async {
    try {
      await verifyEmailUsecase();
      Get.snackbar(
        'Success',
        'Verification email sent. Please check your inbox.',
      );
    } catch (e) {
      Get.snackbar('Error', 'Email Sending failed due to ${e.toString()}');
    }
  }

  Future<bool> isEmailVerified() async {
    bool val = false;
    try {
      val = await checkEmailVerifiedUseCase();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return val;
  }

  Future<void> updateUserProfile(UserEntity user) async {
    return await editProfileUseCase(user);
  }

  Future<bool> checkUserSession() async {
    try {
      final user = await checkSessionUseCase();
      if (user != null) {
        currentUser.value = user;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void loadAddresses(List<Address> list) {
    addresses.assignAll(list);
  }

  void addAddress(Address address) {
    addresses.add(address);
    // Save to backend (Firebase)
    saveAddressesToBackend();
  }

  void selectDefaultAddress(Address address) {
    for (var addr in addresses) {
      addr.isDefault = false;
    }
    address.isDefault = true;
    addresses.refresh();
    saveAddressesToBackend();
  }

  void saveAddressesToBackend() async {
    final user = currentUser.value;
    if (user == null) return;
    try {
      // Convert addresses to List<Map<String, dynamic>>
      final addressList = addresses.map((a) => a.toMap()).toList();
      await _authDataSource.updateUserAddresses(user.uid, addressList);
      Get.snackbar('Success', 'Addresses updated successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update addresses: ${e.toString()}');
    }
  }

  Future<void> loadAddressesFromBackend() async {
    final user = currentUser.value;
    if (user == null) return;
    try {
      final fetched = await _authDataSource.fetchUserAddresses(user.uid);
      addresses.assignAll(fetched);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load addresses: ${e.toString()}');
    }
  }
}
