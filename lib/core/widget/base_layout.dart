import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

import '../config/app_config.dart';
import '../const/app_mode.dart';
import '../util/shake_log_sender.dart';
import 'base_dialog.dart';

class BaseLayout extends StatefulWidget {
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
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  ShakeDetector? detector;

  @override
  void initState() {
    super.initState();
    if (AppConfig.appMode == AppMode.dev) {
      ShakeLogSender.getShakeLogSender(
        onSuccess: () {
          showDialog(
            context: context,
            builder: (_) => const BaseDialog(
              content: Text('로그 전송 성공'),
            ),
          );
        },
        onError: (msg) {
          showDialog(
            context: context,
            builder: (_) => BaseDialog(
              content: Text('로그 전송 실패\n$msg'),
            ),
          );
        },
      ).then((value) {
        detector = value;
        detector?.startListening();
      });
    }
  }

  @override
  void dispose() {
    if (detector != null && AppConfig.appMode == AppMode.dev) {
      detector?.stopListening();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.onWillPop,
      child: IgnorePointer(
        ignoring: widget.ignoring,
        child: Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
              backgroundColor: widget.backgroundColor ?? Theme.of(context).colorScheme.background,
              appBar: widget.appBar,
              body: widget.child,
              bottomNavigationBar: widget.bottomNavigationBar,
            ),
            Visibility(
              visible: widget.isLoading,
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
