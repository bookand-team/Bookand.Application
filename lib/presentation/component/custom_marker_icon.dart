import 'package:bookand/core/theme/color_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../gen/assets.gen.dart';

class CustomMarkerIcon extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;

  const CustomMarkerIcon({
    super.key,
    required this.label,
    this.width,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          Assets.images.map.bookstoreBig,
          width: width,
          height: height,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: const Color(0xCCFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            label,
            style: const TextStyle(
                color: lightColorFF222222,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3),
          ),
        )
      ],
    );
  }
}
