import 'package:flutter/material.dart';

class CommonLayout extends StatelessWidget {
  final Color? backgroundColor;
  final WillPopCallback? onWillPop;
  final bool ignoring;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool isLoading;
  final Widget child;

  const CommonLayout({
    Key? key,
    this.backgroundColor,
    this.onWillPop,
    this.ignoring = false,
    this.appBar,
    this.bottomNavigationBar,
    this.isLoading = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: IgnorePointer(
        ignoring: ignoring,
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.background,
              appBar: appBar,
              body: child,
              bottomNavigationBar: bottomNavigationBar,
            ),
            Visibility(visible: isLoading, child: const Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
    );
  }
}
