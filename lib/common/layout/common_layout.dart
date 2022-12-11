import 'package:flutter/material.dart';

class CommonLayout extends StatelessWidget {
  final Color? backgroundColor;
  final WillPopCallback? onWillPop;
  final bool ignoring;
  final PreferredSizeWidget? appBar;
  final Widget child;
  final bool isLoading;

  const CommonLayout(
      {Key? key,
      this.backgroundColor,
      this.onWillPop,
      this.ignoring = false,
      this.appBar,
      required this.child,
      this.isLoading = false})
      : super(key: key);

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
            ),
            Visibility(visible: isLoading, child: const Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
    );
  }
}
