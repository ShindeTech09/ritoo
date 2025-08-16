import 'package:flutter/material.dart';
import '../../widgets/app_scaffold.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Payment',
      body: Center(child: Text('Payment options go here')),
    );
  }
}
