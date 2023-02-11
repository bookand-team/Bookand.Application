import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final Function() onTap;
  final Widget image;
  final Widget text;

  const SocialLoginButton(
      {super.key,
      required this.onTap,
      required this.image,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFF999999)),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: InkWell(
          onTap: onTap,
          hoverColor: Colors.black12,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                alignment: Alignment.center,
                child: text,
              ),
              Positioned(left: 18, child: image)
            ],
          ),
        ));
  }
}
