import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../gen/assets.gen.dart';

class ListButton extends StatelessWidget {
  final bool status;
  final void Function() onTap;
  const ListButton({super.key, required this.onTap, required this.status});
  final double size = 32;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: size,
          alignment: Alignment.center,
          width: size,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(1000))),
          child: SvgPicture.asset(
            Assets.images.map.listIcon,
            width: 24,
            height: 24,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                status ? const Color(0xffF86C30) : Colors.black,
                BlendMode.srcIn),
          )),
    );
  }
}
