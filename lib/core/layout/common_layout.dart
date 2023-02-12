import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

import '../../presentation/component/custom_dialog.dart';
import '../config/app_config.dart';
import '../const/app_mode.dart';
import '../util/shake_log_sender.dart';

class CommonLayout extends StatefulWidget {
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
  State<CommonLayout> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> with CustomDialog {
  ShakeDetector? detector;

  @override
  void initState() {
    super.initState();
    if (AppConfig.appMode == AppMode.dev) {
      ShakeLogSender.getShakeLogSender(
        onSuccess: () {
          showOneBtnDialog(context: context, content: '로그 전송 성공');
        },
        onError: (msg) {
          showOneBtnDialog(context: context, title: '로그 전송 실패', content: msg);
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
