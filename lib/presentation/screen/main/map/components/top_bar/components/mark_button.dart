import 'package:flutter/material.dart';

class MarkButton extends StatelessWidget {
  const MarkButton({Key? key}) : super(key: key);

  final double bRauius = 15;
  final Size size = const Size(55, 28);
  final double margin = 5;
  final double horiPadding = 12;
  final double vertPadding = 5;
  final Color grey = const Color(0xffdddddd);
  final TextStyle textStyle = const TextStyle(fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      margin: EdgeInsets.all(margin),
      width: size.width,
      height: size.height,
      padding:
          EdgeInsets.symmetric(vertical: vertPadding, horizontal: horiPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: grey),
          borderRadius: BorderRadius.all(Radius.circular(bRauius))),
      child: Text(
        '북마크',
        style: textStyle,
      ),
    ));
  }
}
