// lib/presentations/pages/edit_profile_page.dart

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:retoverse/domain/entities/user_entity.dart';
import 'package:retoverse/presentations/controllers/auth_controller.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final authController = Get.find<AuthController>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  DateTime dob = DateTime(2000, 1, 1);
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    final user = authController.currentUser.value;
    if (user != null) {
      nameController.text = user.name ?? '';
      emailController.text = user.email;
      mobileController.text = user.phone ?? '';
      dob = _parseDOB(user.dob);
      selectedGender = user.gender;
    }
  }

  DateTime _parseDOB(String? dobString) {
    if (dobString == null) return DateTime(2000, 1, 1);
    try {
      return DateFormat('dd-MM-yyyy').parse(dobString);
    } catch (_) {
      return DateTime(2000, 1, 1);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  Future<void> _onUpdateProfile() async {
    final user = authController.currentUser.value;
    if (user == null) return;

    final updatedUser = UserEntity(
      uid: user.uid,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: mobileController.text.trim(),
      dob: DateFormat('dd-MM-yyyy').format(dob),
      gender: selectedGender,
      addresses: user.addresses,
      points: user.points,
    );

    try {
      await authController.updateUserProfile(updatedUser);
      Get.snackbar('Success', 'Profile updated successfully');
      Get.offNamed(AppRoutes.PROFILE);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUser.value;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Avatar
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue.shade100,
                child: Icon(
                  Icons.person,
                  size: 48,
                  color: Colors.blue.shade700,
                ),
              ),
            ),
            const Gap(16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const Gap(12),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      readOnly: true,
                    ),
                    const Gap(12),
                    TextField(
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                      ),
                    ),
                    const Gap(12),
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: dob,
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() => dob = picked);
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(DateFormat('dd MMM yyyy').format(dob)),
                      ),
                    ),
                    const Gap(12),
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      onChanged: (val) => setState(() => selectedGender = val),
                      items: ['Male', 'Female', 'Other']
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                      decoration: const InputDecoration(labelText: 'Gender'),
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
                    if (user != null && user.addresses.isNotEmpty)
                      ...user.addresses.map(
                        (address) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
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
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(8),
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
                    else
                      Text(
                        'No addresses added.',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                  ],
                ),
              ),
            ),
            const Gap(24),

            // Update Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _onUpdateProfile,
                icon: Icon(Icons.save),
                label: const Text('Update Profile'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
