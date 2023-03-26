import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({Key? key}) : super(key: key);

  final double bRauius = 15;
  final Size size = const Size(55, 28);
  final double margin = 5;
  final double horiPadding = 12;
  final double vertPadding = 5;
  final Color grey = const Color(0xffdddddd);
  final TextStyle textStyle = const TextStyle(fontSize: 12);
  final double iconSize = 6;

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
      child: Row(
        children: [
          Text(
            '테마',
            style: textStyle,
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: iconSize,
          )
        ],
      ),
    ));
  }
}
