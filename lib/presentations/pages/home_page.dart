// lib/presentations/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/utils/responsive_widget.dart';
import 'package:retoverse/presentations/controllers/auth_controller.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final authController = Get.find<AuthController>();

  void _logout() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    await authController.logout();
    Get.back(); // Close dialog
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final name = authController.currentUser.value?.name ?? '';
          return Text("Welcome, $name");
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline_sharp),
            onPressed: () => Get.toNamed(AppRoutes.PROFILE),
          ),
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: ResponsiveWidget(
        mobile: const _HomeContent(),
        desktop: const _HomeContent(),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.shopping_bag, size: 72, color: Colors.deepPurple),
          const SizedBox(height: 24),
          Obx(() {
            final email = authController.currentUser.value?.email ?? '';
            return Text(
              "Logged in as $email",
              style: const TextStyle(fontSize: 18),
            );
          }),
          const SizedBox(height: 12),
          const Text(
            "Start exploring the Ritoverse store!",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
