import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/utils/responsive_widget.dart';
import 'package:retoverse/presentations/controllers/auth_controller.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Image.asset('assets/logo/home_logo.png', width: 250),
        centerTitle: Get.width <= 600,
      ),
      body: ResponsiveWidget(
        mobile: _buildForm(context),
        desktop: _buildForm(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),

                // Full Name
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Full Name"),
                  validator: (value) =>
                      value != null && value.trim().length >= 3
                      ? null
                      : 'Enter your full name',
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value != null && value.isEmail
                      ? null
                      : 'Enter a valid email',
                ),
                const SizedBox(height: 16),

                // Password
                Obx(
                  () => TextFormField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: isPasswordVisible.toggle,
                      ),
                    ),
                    validator: (value) => value != null && value.length >= 6
                        ? null
                        : 'Password must be 6+ characters',
                  ),
                ),
                const SizedBox(height: 24),

                // Register Button
                Obx(
                  () => isLoading.value
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                isLoading.value = true;
                                await authController.register(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  nameController.text.trim(),
                                );
                                isLoading.value = false;
                                Get.offAllNamed(AppRoutes.SPLASH);
                              }
                            },
                            child: const Text('Register'),
                          ),
                        ),
                ),

                const SizedBox(height: 16),

                // Login Redirect
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.LOGIN),
                  child: const Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
