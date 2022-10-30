import 'package:flutter/material.dart';

mixin CustomDialog {
  void showInfoDialog(BuildContext context, String title, String content, String btnName,
          Function() onPressed) =>
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [ElevatedButton(onPressed: onPressed, child: Text(btnName))],
            );
          });
}
