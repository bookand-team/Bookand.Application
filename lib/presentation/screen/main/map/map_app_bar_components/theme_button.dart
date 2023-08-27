import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemeButton extends StatelessWidget {
  final void Function() onTap;
  final void Function() onClear;
  final List<Themes> selectedThemes;
  const ThemeButton(
      {Key? key,
      required this.selectedThemes,
      required this.onTap,
      required this.onClear})
      : super(key: key);

  final double bRauius = 15;
  final double margin = 5;
  final double horiPadding = 12;
  final double vertPadding = 5;

  final double height = 28;
  final double iconSize = 12;

  final TextStyle textStyle = const TextStyle(fontSize: 12);

  final Color grey = const Color(0xffdddddd);
  final Color selectedColor = const Color(0xfff86c30);

  @override
  Widget build(BuildContext context) {
    final bool selected = selectedThemes.isNotEmpty;
    String getContent() {
      String data = '테마';
      //체크한 테마가 하나이상이면
      if (selected) {
        int len = selectedThemes.length;
        //선택한 게 하나면
        if (len == 1) {
          data = ThemeUtils.theme2Str(selectedThemes.first)!;
        }
        //둘 이상이면
        else {
          data += ' $len';
        }
      }
      return data;
    }

    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(
              vertical: vertPadding, horizontal: horiPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: selected ? selectedColor : grey),
              borderRadius: BorderRadius.all(Radius.circular(bRauius))),
          child: Row(
            children: [
              Text(getContent(),
                  style: TextStyle(
                    color: selected ? selectedColor : const Color(0xFF222222),
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    // height: 18,
                    letterSpacing: -0.24,
                  )),
              const SizedBox(
                width: 3,
              ),
              selected
                  ? GestureDetector(
                      onTap: () => onClear(),
                      child: SvgPicture.asset(Assets.images.map.clsoeIcon))
                  : Container(
                      padding: const EdgeInsets.only(top: 2),
                      child: SvgPicture.asset(Assets.images.map.downVectorIcon))
            ],
          ),
        ));
  }
}
