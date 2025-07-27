import 'package:flutter/material.dart';

// class ResponsiveWidget extends StatelessWidget {
//   final Widget mobile;
//   final Widget tablet;
//   final Widget desktop;
//   const ResponsiveWidget({
//     super.key,
//     required this.mobile,
//     required this.tablet,
//     required this.desktop,
//   });

//   static bool isMobile(BuildContext context) =>
//       MediaQuery.of(context).size.width < 600;

//   static bool isTablet(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 600 &&
//       MediaQuery.of(context).size.width <= 1100;

//   static bool isDesktop(BuildContext context) =>
//       MediaQuery.of(context).size.width > 1100;

//   @override
//   Widget build(BuildContext context) {
//     if (isDesktop(context) && desktop != null) {
//       return desktop;
//     } else if (isTablet(context) && tablet != null) {
//       return tablet;
//     } else {
//       return mobile;
//     }
//   }
// }

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) =>
          constraints.maxWidth < 600 ? mobile : desktop,
    );
  }
}
