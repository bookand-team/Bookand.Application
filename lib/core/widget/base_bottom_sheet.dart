import 'package:flutter/material.dart';

void showCustomBottomSheet(BuildContext context) {
  double maxHeight = MediaQuery.of(context).size.height;
  double minHeight = 200;
  showModalBottomSheet(
    isScrollControlled: true,
    constraints: BoxConstraints(minHeight: minHeight, maxHeight: maxHeight),
    context: context,
    builder: (context) {
      return const BaseBottomSheet();
    },
  );
}

class BaseBottomSheet extends StatefulWidget {
  const BaseBottomSheet({Key? key}) : super(key: key);

  @override
  BaseBottomSheetState createState() => BaseBottomSheetState();
}

class BaseBottomSheetState extends State<BaseBottomSheet> {
  double height = 200;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          height += details.delta.dy;
        });
      },
      child: Container(
        height: height,
      ),
    );
  }
}
