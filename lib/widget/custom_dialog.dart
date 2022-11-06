import 'package:flutter/material.dart';

mixin CustomDialog {
  void showOneBtnDialog(
          {required BuildContext context,
          String title = '안내',
          required String content,
          String btnName = '확인',
          Function()? onPressed}) =>
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: Text(content),
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
