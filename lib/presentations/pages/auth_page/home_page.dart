// lib/presentations/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/utils/responsive_widget.dart';
import 'package:retoverse/presentations/controllers/auth_controller.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

import '../../controllers/home_contoller.dart';
import 'home_content.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final authController = Get.find<AuthController>();
  final controller = Get.find<HomeController>();

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final name = authController.currentUser.value?.name ?? '';
          return Text(
            'Hello, $name',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline_sharp),
            onPressed: () => Get.toNamed(AppRoutes.PROFILE),
          ),
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: ResponsiveWidget(mobile: HomeContent(), desktop: HomeContent()),
    );
  }
}
