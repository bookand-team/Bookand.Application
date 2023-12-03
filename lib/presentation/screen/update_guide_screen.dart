import 'package:bookand/core/widget/common_dialog.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateGuideScreen extends StatefulWidget {
  static String get routeName => 'updateGuide';

  const UpdateGuideScreen({Key? key}) : super(key: key);

  @override
  State<UpdateGuideScreen> createState() => _UpdateGuideScreenState();
}

class _UpdateGuideScreenState extends State<UpdateGuideScreen> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    if (!isShow) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showUpdateDialog();
      });
      isShow = true;
    }

    return BaseLayout(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: const SizedBox(),
    );
  }

  void showUpdateDialog() {
    showDialog(
      context: context,
      builder: (_) => CommonDialog(
        isTwoBtn: true,
        negativeBtnText: '종료',
        positiveBtnText: '업데이트',
        content: const Text('새로운 버전이 있습니다.\n업데이트를 진행해주세요.'),
        onTapNegativeBtn: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
        onTapPositiveBtn: () {
          // TODO: 스토어로 이동
          // if (Platform.isAndroid) {
          //
          // } else {
          //
          // }
        },
      ),
      barrierDismissible: false,
    );
  }
}
