import 'package:flutter/material.dart';

class RecommendationButton extends StatelessWidget {
  const RecommendationButton({Key? key}) : super(key: key);

  final Size size = const Size(328, 56);
  final EdgeInsets padding = const EdgeInsets.symmetric(vertical: 10);
  final TextStyle textStyle = const TextStyle(color: Colors.white);
  final double bRadius = 8;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: size.width,
        height: size.height,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(bRadius)),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            '숨은 서점 추천 받기',
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
