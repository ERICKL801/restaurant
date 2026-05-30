import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

enum ScreenSize { mobile, tablet, desktop }

class AppResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const AppResponsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppConstants.mobileBreakpoint) return ScreenSize.mobile;
    if (width < AppConstants.desktopBreakpoint) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  static bool isMobile(BuildContext context) =>
      getScreenSize(context) == ScreenSize.mobile;

  static bool isTablet(BuildContext context) =>
      getScreenSize(context) == ScreenSize.tablet;

  static bool isDesktop(BuildContext context) =>
      getScreenSize(context) == ScreenSize.desktop;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double bottomPadding(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  static double topPadding(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  @override
  Widget build(BuildContext context) {
    final size = getScreenSize(context);
    switch (size) {
      case ScreenSize.mobile:
        return mobile;
      case ScreenSize.tablet:
        return tablet ?? mobile;
      case ScreenSize.desktop:
        return desktop;
    }
  }
}
