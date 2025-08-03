// lib/presentations/pages/profile_page.dart

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:retoverse/presentations/controllers/auth_controller.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final authController = Get.find<AuthController>();

  void _logout() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    await authController.logout();
    Get.back(); // close dialog
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Obx(() {
        final user = authController.currentUser.value;

        if (user == null) {
          return const Center(child: Text('No user data available'));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileRow(label: "Name", value: user.name!),
              const Gap(10),
              ProfileRow(label: "Email", value: user.email),
              const Gap(10),
              ProfileRow(
                label: "Date of Birth",
                value: user.dob ?? "Not provided",
              ),
              const Gap(10),
              ProfileRow(
                label: "Gender",
                value: user.gender ?? "Not specified",
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.EDITPROFILE),
                child: const Text('Edit Profile'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text("$label: $value", style: const TextStyle(fontSize: 18));
  }
}
