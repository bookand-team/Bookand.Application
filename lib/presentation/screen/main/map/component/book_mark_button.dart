import 'package:bookand/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookMarkButton extends StatelessWidget {
  final bool acitve;
  final void Function() onAcive;
  final void Function() onDisactive;
  const BookMarkButton(
      {Key? key,
      required this.acitve,
      required this.onAcive,
      required this.onDisactive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (acitve) {
          onDisactive();
        } else {
          onAcive();
        }
      },
      child: Container(
        child: acitve
            ? SvgPicture.asset(Assets.images.map.bookmarkActive)
            : SvgPicture.asset(Assets.images.map.bookmarkDeactive),
      ),
    );
  }
}
