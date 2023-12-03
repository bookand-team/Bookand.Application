import 'package:flutter/material.dart';

class MapAppbarBookMarkButton extends StatelessWidget {
  final bool status;
  final void Function() onTap;
  const MapAppbarBookMarkButton(
      {Key? key, required this.status, required this.onTap})
      : super(key: key);

  final double bRauius = 15;
  final Size size = const Size(55, 28);
  final double horiPadding = 12;
  final double vertPadding = 5;
  final Color grey = const Color(0xffdddddd);
  final Color selectedColor = const Color(0xfff86c30);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          // width: size.width,
          height: size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              vertical: vertPadding, horizontal: horiPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: status ? selectedColor : grey),
              borderRadius: BorderRadius.all(Radius.circular(bRauius))),
          child: Text(
            '북마크',
            style: TextStyle(
              color: status ? selectedColor : Color(0xFF222222),
              fontSize: 12,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              // height: 18,
              letterSpacing: -0.24,
            ),
          ),
        ));
  }
}
