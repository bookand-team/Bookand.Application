import 'package:bookand/presentation/provider/map/bools/map_theme_toggle.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_bottomsheet_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_theme_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:flutter/material.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

//components
import '../../theme_bottom_sheet/theme_bottom_sheet.dart';

class ThemeButton extends ConsumerWidget {
  const ThemeButton({Key? key}) : super(key: key);

  final double bRauius = 15;
  final double margin = 5;
  final double horiPadding = 12;
  final double vertPadding = 5;

  final Size size = const Size(55, 28);
  final double iconSize = 6;

  final TextStyle textStyle = const TextStyle(fontSize: 12);

  final Color grey = const Color(0xffdddddd);
  final Color selectedColor = const Color(0xfff86c30);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Themes> selectedThemes = ref.watch(mapThemeNotifierProvider);
    final themeCon = ref.read(mapThemeNotifierProvider.notifier);
    final bool buttonSelected = ref.watch(themeToggleNotifierProvider);
    final buttonSelectCon = ref.watch(themeToggleNotifierProvider.notifier);
    final bool themeSelected = selectedThemes.isNotEmpty;
    final bool selected = buttonSelected || themeSelected;
    String getContent() {
      String data = '테마';
      //체크한 테마가 하나이상이면
      if (themeSelected) {
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
        onTap: () {
          ref.read(mapBottomSheetControllerProvider.notifier).close();
          buttonSelectCon.activate();
          showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              builder: (context) => const ThemeBottomSheet());
        },
        child: Container(
          // width: size.width,
          height: size.height,
          padding: EdgeInsets.symmetric(
              vertical: vertPadding, horizontal: horiPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: selected ? selectedColor : grey),
              borderRadius: BorderRadius.all(Radius.circular(bRauius))),
          child: Row(
            children: [
              Text(
                getContent(),
                style:
                    textStyle.copyWith(color: selected ? selectedColor : null),
              ),
              selected
                  ? GestureDetector(
                      onTap: () => themeCon.init(),
                      child: Icon(
                        Icons.close,
                        color: selectedColor,
                        size: iconSize,
                      ),
                    )
                  : Icon(
                      Icons.keyboard_arrow_down,
                      size: iconSize,
                    )
            ],
          ),
        ));
  }
}
