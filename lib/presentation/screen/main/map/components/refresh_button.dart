import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({Key? key}) : super(key: key);

  final Color color = const Color(0xfff5f5f7);
  final Size imageSize = const Size(17.57, 17.57);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(1000)),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
