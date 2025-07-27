import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/utils/responsive_widget.dart';
import 'package:retoverse/presentations/controllers/auth_controller.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authController = Get.find<AuthController>();
  final RxBool _isLoading = false.obs;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    if (_formKey.currentState!.validate()) {
      _isLoading.value = true;
      try {
        await _authController.sendPasswordResetEmail(
          _emailController.text.trim(),
        );
        Get.snackbar('Success', 'Password reset link sent to email');
        Get.offAllNamed(AppRoutes.SPLASH);
      } catch (e) {
        Get.snackbar('Error', e.toString());
      } finally {
        _isLoading.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Image(
          image: AssetImage('assets/logo/home_logo.png'),
          width: 250,
        ),
        centerTitle: Get.width <= 600,
      ),
      body: ResponsiveWidget(mobile: _buildForm(), desktop: _buildForm()),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Gap(32),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => (value == null || !value.contains('@'))
                      ? 'Enter valid email'
                      : null,
                ),
                const Gap(24),
                Obx(() {
                  return _isLoading.value
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _sendResetLink,
                            child: const Text('Send Reset Link'),
                          ),
                        );
                }),
                const Gap(16),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
