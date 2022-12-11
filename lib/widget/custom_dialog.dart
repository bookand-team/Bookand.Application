import 'package:flutter/material.dart';

import '../common/const/app_mode.dart';
import '../config/app_config.dart';

mixin CustomDialog {
  void showOneBtnDialog(
          {required BuildContext context,
          String title = '안내',
          required String content,
          String btnName = '확인',
          Function()? onPressed}) async =>
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: AppConfig.appMode == AppMode.dev
                  ? SingleChildScrollView(child: SelectableText(content))
                  : Text(content),
              actions: [
                ElevatedButton(
                    onPressed: onPressed ??
                        () {
                          Navigator.pop(context);
                        },
                    child: Text(btnName))
              ],
            );
          });
}
