import 'package:flutter/material.dart';
import '../../core/responsive/app_responsive.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        child: AppResponsive(
          mobile: _MobileLayout(body: body),
          tablet: _TabletLayout(body: body),
          desktop: _DesktopLayout(body: body),
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final Widget body;
  const _MobileLayout({required this.body});

  @override
  Widget build(BuildContext context) {
    return body;
  }
}

class _TabletLayout extends StatelessWidget {
  final Widget body;
  const _TabletLayout({required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: body,
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final Widget body;
  const _DesktopLayout({required this.body});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: body,
      ),
    );
  }
}
