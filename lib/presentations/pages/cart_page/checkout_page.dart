import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/presentations/pages/cart_page/add_address_page.dart';
import 'package:retoverse/presentations/pages/cart_page/payment_page.dart';
import '../../widgets/app_scaffold.dart';
import '../../controllers/auth_controller.dart';

class CheckoutPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Checkout',
      body: Obx(() {
        if (authController.addresses.isEmpty) {
          return Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.add_location),
              label: Text('Add Address'),
              onPressed: () {
                Get.to(() => AddAddressPage());
              },
            ),
          );
        }
        return ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              'Select Delivery Address:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ...authController.addresses.map(
              (address) => ListTile(
                title: Text(address.fullAddress),
                leading: Icon(Icons.location_on),
                trailing: address.isDefault
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  authController.selectDefaultAddress(address);
                  Get.to(() => PaymentPage());
                },
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('Add New Address'),
              onPressed: () {
                Get.to(() => AddAddressPage());
              },
            ),
          ],
        );
      }),
    );
  }
}
