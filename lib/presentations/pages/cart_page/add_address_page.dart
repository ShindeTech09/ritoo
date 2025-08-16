import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/presentations/pages/cart_page/address.dart';
import '../../widgets/app_scaffold.dart';
import '../../controllers/auth_controller.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final houseController = TextEditingController();
  final buildingController = TextEditingController();
  final streetController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final talukaController = TextEditingController();
  final districtController = TextEditingController();
  final pinController = TextEditingController();
  String? selectedState;

  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();

  final List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Add Address',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: houseController,
                decoration: InputDecoration(labelText: 'House/Flat Number *'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: buildingController,
                decoration: InputDecoration(labelText: 'Building Name'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: streetController,
                decoration: InputDecoration(labelText: 'Street/Road'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: areaController,
                decoration: InputDecoration(labelText: 'Area/Locality'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City *'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: talukaController,
                decoration: InputDecoration(labelText: 'Taluka'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: districtController,
                decoration: InputDecoration(labelText: 'District'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedState,
                decoration: InputDecoration(labelText: 'State *'),
                items: states
                    .map(
                      (state) =>
                          DropdownMenuItem(value: state, child: Text(state)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => selectedState = val),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: pinController,
                decoration: InputDecoration(labelText: 'Pin Code *'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  label: Text('Save Address'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final addressString = [
                        houseController.text,
                        buildingController.text,
                        streetController.text,
                        areaController.text,
                        cityController.text,
                        talukaController.text,
                        districtController.text,
                        selectedState ?? '',
                        pinController.text,
                      ].where((e) => e.trim().isNotEmpty).join(', ');

                      final address = Address(
                        fullAddress: addressString,
                        isDefault: authController.addresses.isEmpty,
                      );
                      authController.addAddress(address);
                      Get.back();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
