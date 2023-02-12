import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: SvgPicture.asset(
          value
              ? 'assets/images/ic_all_check_active.svg'
              : 'assets/images/ic_all_check_inactive.svg',
        ),
      ),
    );
  }
}
