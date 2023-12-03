import 'package:bookand/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

showConfirmSnackBar(BuildContext context, String data) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: const EdgeInsets.symmetric(vertical: 16),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      backgroundColor: const Color(0xff222222).withOpacity(0.85),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.images.bookmark.icDeleteSnackbarIcon,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            data,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      )));
}

SnackBar createSnackBar({required String data}) {
  return SnackBar(
      padding: const EdgeInsets.symmetric(vertical: 16),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      backgroundColor: const Color(0xff222222).withOpacity(0.85),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.images.bookmark.icDeleteSnackbarIcon,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            data,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ));
}
