import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final double width;
  final double height;
  final double radius;
  final Widget image;
  final Widget text;

  const SocialLoginButton(
      {super.key,
      required this.onTap,
      required this.width,
      required this.radius,
      required this.height,
      required this.image,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFF999999)),
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: InkWell(
          onTap: onTap,
          hoverColor: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                child: text,
              ),
              Positioned(left: 18, child: image)
            ],
          ),
        ));
  }
}
