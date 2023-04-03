import 'package:bookand/core/widget/slide_icon.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/provider/map/map_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ThemeDialog extends ConsumerStatefulWidget {
  const ThemeDialog({Key? key}) : super(key: key);

  @override
  _ThemeDialogState createState() => _ThemeDialogState();
}

class _ThemeDialogState extends ConsumerState<ThemeDialog> {
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

  List<String> options = MapThemeNotifier.options;
  List<String> selectedList = [];
  //
  late ThemeToggleNotifier buttonSelectCon;
  late MapThemeNotifier themeCon;

  @override
  void initState() {
    buttonSelectCon = ref.read(themeToggleProvider.notifier);
    selectedList = ref.read(mapThemeNotifierProvider);
    themeCon = ref.read(mapThemeNotifierProvider.notifier);
    super.initState();
  }

  @override
  void dispose() {
    //위젯이 사라질 때 button selection은 deactivate, theme 선택한 게 있으면 그걸로 활성화 여부 판별
    Future.delayed(
        const Duration(milliseconds: 100), () => buttonSelectCon.deactivate());

    super.dispose();
  }

  void toggleTheme(String value) {
    //안전성 점검
    if (options.contains(value)) {
      //있으면 제거
      if (selectedList.contains(value)) {
        setState(() {
          selectedList.remove(value);
        });
      }
      //없으면 추가
      else {
        setState(() {
          selectedList.add(value);
        });
      }
    }
  }

  void initThemes() {
    themeCon.initThemes();
    setState(() {
      selectedList = [];
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

  @override
  Widget build(BuildContext context) {
    bool themeSelected = selectedList.isNotEmpty;
    Size screenSize = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: bRaidus, topRight: bRaidus, bottomLeft: Radius.zero)),
      insetPadding: EdgeInsets.zero,
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: padding,
        width: 1000,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                children: List.generate(options.length, (index) {
                  String value = options[index];
                  bool chipSelected = selectedList.contains(value);
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
                          options[index],
                        ),
                      ),
                      onSelected: (_) {
                        toggleTheme(value);
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
                themeCon.addThemes(selectedList);
                context.pop();
              },
              child: Container(
                width: buttonSize.width,
                height: buttonSize.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(buttonRaidus),
                    color: themeSelected ? selectedColor : buttonColor),
                child: Center(
                    child: Text(
                  '적용',
                  style: buttonStyle.copyWith(
                      color: themeSelected ? Colors.white : null),
                )),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
