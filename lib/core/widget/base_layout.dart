import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final WillPopCallback? onWillPop;
  final bool ignoring;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool isLoading;
  final Widget child;

  const BaseLayout({
    Key? key,
    this.resizeToAvoidBottomInset,
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
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.background,
              appBar: appBar,
              body: child,
              bottomNavigationBar: bottomNavigationBar,
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black12,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
