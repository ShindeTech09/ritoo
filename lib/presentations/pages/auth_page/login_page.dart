import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/utils/responsive_widget.dart';
import 'package:retoverse/presentations/controllers/auth_controller.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Image(
          image: AssetImage('assets/logo/home_logo.png'),
          width: 250,
        ),
        centerTitle: Get.width > 600 ? false : true,
      ),
      body: ResponsiveWidget(
        mobile: loginPage(
          context,
          _formKey,
          emailController,
          passwordController,
          isPasswordVisible,
          isLoading,
          authController,
        ),

        desktop: loginPage(
          context,
          _formKey,
          emailController,
          passwordController,
          isPasswordVisible,
          isLoading,
          authController,
        ),
      ),
    );
  }
}

Widget loginPage(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController emailController,
  TextEditingController passwordController,
  RxBool isPasswordVisible,
  RxBool isLoading,
  AuthController authController,
) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value != null && value.isEmail
                    ? null
                    : 'Enter a valid email',
              ),
              const SizedBox(height: 16),
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
                      onPressed: () => isPasswordVisible.toggle(),
                    ),
                  ),
                  validator: (value) => value != null && value.length >= 6
                      ? null
                      : 'Password must be 6+ characters',
                ),
              ),
              Gap(12),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.FORGOT_PASSWORD);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ],
              ),
              Gap(12),
              Obx(
                () => isLoading.value
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading.value = true;
                              await authController.login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                              isLoading.value = false;
                              Get.offAllNamed(AppRoutes.SPLASH);
                            }
                          },
                          child: const Text("Login"),
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.REGISTER),
                child: const Text("Don't have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
