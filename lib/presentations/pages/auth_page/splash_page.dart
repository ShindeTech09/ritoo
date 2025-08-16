import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/presentations/controllers/auth_controller.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    // Resolve controller inside initState (after GetMaterialApp + initialBinding are active)
    authController = Get.find<AuthController>();

    // Kick off session check after a microtask to ensure bindings completed
    Future.microtask(() async {
      final isLoggedIn = await authController.checkUserSession();
      if (mounted) {
        if (isLoggedIn) {
          Get.offAllNamed(AppRoutes.HOME);
        } else {
          Get.offAllNamed(AppRoutes.LOGIN);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
