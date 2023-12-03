import 'package:flutter/material.dart';

class HideBookStoreButton extends StatelessWidget {
  final bool status;
  final void Function() onTap;
  const HideBookStoreButton({
    Key? key,
    required this.status,
    required this.onTap,
  }) : super(key: key);

  final double bRauius = 15;
  final Size size = const Size(80, 28);
  final double margin = 5;
  final double horiPadding = 12;
  final double vertPadding = 5;
  final Color grey = const Color(0xffdddddd);
  final TextStyle textStyle = const TextStyle(fontSize: 12);
  final TextStyle hideTitle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xff222222));

  final bottomSheetPadding =
      const EdgeInsets.symmetric(horizontal: 15, vertical: 5);
  final bottomSheetBr = const Radius.circular(24);
  final double bottomSheetHeight = 350;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: size.height,
          padding: EdgeInsets.symmetric(
              vertical: vertPadding, horizontal: horiPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: status ? Colors.black : grey),
              borderRadius: BorderRadius.all(Radius.circular(bRauius))),
          child: Row(
            children: [
              Text(
                '✨ 숨은 서점',
                style: textStyle,
              ),
            ],
          ),
        ));
  }
}
