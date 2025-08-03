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
      emailController.text = user.email ?? '';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
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
            ),
            const Gap(12),
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Mobile Number'),
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
                    (gender) =>
                        DropdownMenuItem(value: gender, child: Text(gender)),
                  )
                  .toList(),
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            const Gap(24),
            ElevatedButton(
              onPressed: _onUpdateProfile,
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
