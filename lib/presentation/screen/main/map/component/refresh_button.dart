import 'package:bookand/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RefreshButton extends StatelessWidget {
  final void Function() onTap;
  const RefreshButton({Key? key, required this.onTap}) : super(key: key);

  final Color color = const Color(0xfff5f5f7);
  final Size size = const Size(28, 28);
  final Size imageSize = const Size(16, 16);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(1000)),
          child: Center(
            child: SizedBox(
              width: imageSize.width,
              height: imageSize.height,
              child: SvgPicture.asset(
                Assets.images.map.hidestoreReset,
              ),
            ),
          )),
    );
  }
}
