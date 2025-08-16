import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retoverse/presentations/routes/app_routes.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final bool showAppBar;
  final bool showCartIcon;
  final bool showProfileIcon;
  final PreferredSizeWidget? customAppBar;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.showAppBar = true,
    this.showCartIcon = true,
    this.showProfileIcon = true,
    this.customAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? customAppBar ??
                AppBar(
                  title: title.isNotEmpty
                      ? Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : GestureDetector(
                          onTap: () => Get.offAllNamed(AppRoutes.HOME),
                          child: Image(
                            image: AssetImage('assets/logo/home_logo.png'),
                            width: 100,
                          ),
                        ),
                  actions: [
                    if (showCartIcon)
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          Get.toNamed(AppRoutes.CART);
                        },
                      ),
                    if (showProfileIcon)
                      IconButton(
                        icon: const Icon(Icons.person),
                        onPressed: () {
                          Get.toNamed(AppRoutes.PROFILE);
                        },
                      ),
                  ],
                )
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
