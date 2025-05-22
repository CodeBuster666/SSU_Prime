import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget? tabletScaffold;
  final Widget desktopScaffold;

  const Responsive({
    super.key,
    required this.mobileScaffold,
    required this.tabletScaffold,
    required this.desktopScaffold,
  });

  static bool isMobile(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width >= 600 && size.width < 1100;
  }

  static bool isDesktop(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width >= 1100;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // If out width more than 1100px -> desktop
    if (size.width >= 1100) {
      return desktopScaffold;
    }
    // if out width more than 600px -> tablet
    else if (size.width >= 600) {
      return tabletScaffold ?? mobileScaffold;
    }
    // else -> mobile
    else {
      return mobileScaffold;
    }
  }
}
