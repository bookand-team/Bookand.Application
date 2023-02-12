import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/color_table.dart';

class CircleCheckButton extends StatelessWidget {
  final bool value;
  final Function() onTap;

  const CircleCheckButton({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: 60,
        height: 52,
        alignment: Alignment.center,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: value ? lightColorFF222222 : lightColorFFF5F5F7, shape: BoxShape.circle),
          child: SvgPicture.asset(
              value ? 'assets/images/ic_check_white.svg' : 'assets/images/ic_unchecked.svg',
              fit: BoxFit.none),
        ),
      ),
    );
  }
}
