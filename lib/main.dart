import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/core/bindings/auth_bindings.dart';
import 'package:retoverse/firebase_options.dart';
import 'package:retoverse/presentations/routes/app_pages.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.microtask(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });
  runApp(const RetoverseApp());
}

class RetoverseApp extends StatelessWidget {
  const RetoverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "R!!toverse App",
      initialBinding: AuthBindings(),
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
