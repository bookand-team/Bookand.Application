import 'package:flutter/material.dart';
//components
import 'package:bookand/presentation/screen/main/map/components/theme_dialog/theme_dialog.dart';
//providers
import 'package:bookand/presentation/provider/map/map_state_proivders.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final ListType listType = ref.watch(listTypeProvider);
    final con = ref.read(listTypeProvider.notifier);
    final bool selected = listType == ListType.theme;
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ThemeDialog(),
          );
        },
        child: Container(
          margin: EdgeInsets.all(margin),
          width: size.width,
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
                '테마',
                style:
                    textStyle.copyWith(color: selected ? selectedColor : null),
              ),
              selected
                  ? Icon(
                      Icons.close,
                      color: selectedColor,
                      size: iconSize,
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
