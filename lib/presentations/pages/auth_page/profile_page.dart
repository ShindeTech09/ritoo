// lib/presentations/pages/profile_page.dart

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:retoverse/presentations/controllers/auth_controller.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';
import 'package:retoverse/presentations/widgets/app_scaffold.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final authController = Get.find<AuthController>();

  void _logout() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    await authController.logout();
    Get.back();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Profile',
      body: Obx(() {
        final user = authController.currentUser.value;
        if (user == null) {
          return const Center(child: Text('No user data available'));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        Icons.person,
                        size: 48,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      user.name ?? '',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.email,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              const Gap(24),

              // Points Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.amber.shade50,
                elevation: 2,
                child: ListTile(
                  leading: Icon(
                    Icons.star,
                    color: Colors.amber.shade700,
                    size: 32,
                  ),
                  title: Text(
                    'Points',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${user.points ?? 0} pts',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ),
              ),
              const Gap(20),

              // Basic Info Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ProfileRow(
                        label: "Date of Birth",
                        value: user.dob ?? "Not provided",
                      ),
                      const Gap(10),
                      ProfileRow(
                        label: "Gender",
                        value: user.gender ?? "Not specified",
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),

              // Address Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.blue.shade700),
                          const SizedBox(width: 8),
                          Text(
                            'Addresses',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          TextButton.icon(
                            icon: Icon(Icons.add, color: Colors.blue.shade700),
                            label: Text(
                              'Add',
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                            onPressed: () => Get.toNamed(AppRoutes.ADD_ADDRESS),
                          ),
                        ],
                      ),
                      const Gap(8),
                      // Use Obx to listen to the observable addresses list
                      Obx(() {
                        final addresses = authController.addresses;
                        if (addresses.isNotEmpty) {
                          return Column(
                            children: addresses
                                .map(
                                  (address) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.home,
                                          size: 18,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            address.fullAddress,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        if (address.isDefault)
                                          Container(
                                            margin: const EdgeInsets.only(
                                              left: 8,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'Default',
                                              style: TextStyle(
                                                color: Colors.green.shade700,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        } else {
                          return Text(
                            'No addresses added.',
                            style: TextStyle(color: Colors.grey[600]),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
              const Gap(24),

              // Edit and Logout Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Get.toNamed(AppRoutes.EDITPROFILE),
                      icon: Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _logout,
                      icon: Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
      showCartIcon: true,
      showProfileIcon: false,
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$label:",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
      ],
    );
  }
}
