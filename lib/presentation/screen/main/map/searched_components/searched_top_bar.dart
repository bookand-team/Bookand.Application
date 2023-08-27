//providers
import 'package:bookand/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchedAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String query;
  final void Function() onTap;

  static const height = 48;

  @override
  Size get preferredSize => const Size(double.infinity, 48);

  const SearchedAppbar({
    Key? key,
    required this.query,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return renderAppbar();
  }

  Widget renderAppbar() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 13),
          width: double.infinity,
          height: 48,
          child: Row(children: [
            SvgPicture.asset(
              Assets.images.map.icSearchingBack,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 2,
            ),
            Expanded(
              child: Text(
                query,
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: -0.30,
                ),
              ),
            ),
            SvgPicture.asset(
              Assets.images.map.icSearchingDelete,
              width: 16,
              height: 16,
            ),
          ])),
    );
  }
}
