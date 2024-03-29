import 'package:bookand/core/widget/slide_icon.dart';
import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThemeBottomSheet extends StatefulWidget {
  final List<Themes> selectedThemes;
  final void Function(List<Themes> selectedThemes) onApply;
  const ThemeBottomSheet(
      {Key? key, required this.selectedThemes, required this.onApply})
      : super(key: key);

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 15);
  final Radius bRaidus = const Radius.circular(24);
  final Radius chipBRaidus = const Radius.circular(4);

  //고정
  final double wrapSpacing = 15;
  final double wrapVerticalSpacing = 10;

  final Size chipSize = const Size(70, 30);
  final Size buttonSize = const Size(1000, 44);
  final double iconSize = 14;

  final chipColor = const Color(0xfff5f5f7);
  final refreshColor = const Color(0xff565656);
  final buttonColor = const Color(0xffdddddd);
  final selectedColor = const Color(0xff222222);

  final titleStyle = const TextStyle(fontSize: 18, color: Color(0xff222222));
  final refreshStyle = const TextStyle(fontSize: 12, color: Color(0xff565656));
  final chipStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xffacacac));
  final buttonStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xffacacac));

  final buttonRaidus = const Radius.circular(8);

  List<Themes> selectedList = [];
  bool active = false;
  @override
  void initState() {
    selectedList = widget.selectedThemes;
    super.initState();
  }

  void toggleTheme(Themes theme) {
    if (selectedList.contains(theme)) {
      setState(() {
        selectedList.remove(theme);
      });
    } else {
      setState(() {
        selectedList.add(theme);
      });
    }
  }

  void initThemes() {
    setState(() {
      selectedList = [];
      active = !isDifferent();
    });
  }

  Widget getInitButton() {
    return GestureDetector(
      onTap: initThemes,
      child: Row(
        children: [
          Icon(
            Icons.refresh,
            color: refreshColor,
            size: iconSize,
          ),
          Text(
            '초기화',
            style: refreshStyle,
          )
        ],
      ),
    );
  }

  bool isDifferent() {
    List<int> listOne = selectedList.map((e) => e.index).toList();
    List<int> listTwo = [];

    return listEquals(listOne, listTwo);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: bRaidus, topRight: bRaidus)),
      padding: padding,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          slideIcon,
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '테마',
                style: titleStyle,
              ),
              getInitButton()
            ],
          ),

          const SizedBox(
            height: 20,
          ),
          //options 초이스 칩
          SizedBox(
            width: screenSize.width,
            child: Wrap(
              spacing: wrapSpacing,
              runSpacing: wrapVerticalSpacing,
              children: List.generate(Themes.values.length, (index) {
                Themes theme = Themes.values[index];
                String? value = ThemeUtils.theme2Str(theme);
                bool chipSelected = selectedList.contains(theme);
                return SizedBox(
                  width: chipSize.width,
                  height: chipSize.height,
                  child: FilterChip(
                    showCheckmark: false,
                    padding: EdgeInsets.zero,
                    backgroundColor: chipColor,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(chipBRaidus)),
                    selectedColor: selectedColor,
                    selected: chipSelected,
                    labelStyle: chipStyle.copyWith(
                        color: chipSelected ? Colors.white : null),
                    label: Center(
                      child: Text(
                        value!,
                      ),
                    ),
                    onSelected: (_) {
                      toggleTheme(theme);
                      setState(() {
                        active = !isDifferent();
                      });
                    },
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          //적용 버튼
          GestureDetector(
            onTap: () {
              if (active) {
                widget.onApply(selectedList);

                context.pop();
              }
            },
            child: Container(
              width: buttonSize.width,
              height: buttonSize.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(buttonRaidus),
                  color: active ? selectedColor : buttonColor),
              child: Center(
                  child: Text(
                '적용',
                style:
                    buttonStyle.copyWith(color: active ? Colors.white : null),
              )),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
