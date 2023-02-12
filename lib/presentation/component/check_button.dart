import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CheckButton extends StatelessWidget {
  final bool value;
  final Function() onTap;

  const CheckButton(
      {super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        width: 60,
        height: 52,
        alignment: Alignment.center,
        child: SvgPicture.asset(
            value
                ? 'assets/images/ic_checked.svg'
                : 'assets/images/ic_unchecked.svg',
            fit: BoxFit.none),
      ),
    );
  }
}
