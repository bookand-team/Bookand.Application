import 'package:bookand/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class SearchField extends ConsumerWidget {
  final void Function() onTap;
  const SearchField({Key? key, required this.onTap}) : super(key: key);

  final double bRadius = 8;
  final double padding = 10;
  final Color greyColor = const Color(0xffacacac);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            border: Border.all(color: greyColor),
            borderRadius: BorderRadius.all(Radius.circular(bRadius))),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            const Text(
              "궁금한 서점/지역을 검색해 보세요",
              style: TextStyle(
                color: Color(0xffacacac),
                fontSize: 15,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: SvgPicture.asset(
                Assets.images.map.icSearch,
                width: 24,
                height: 24,
                colorFilter:
                    const ColorFilter.mode(Color(0xff222222), BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
