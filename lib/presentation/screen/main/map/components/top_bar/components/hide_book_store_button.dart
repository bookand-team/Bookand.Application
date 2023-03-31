import 'package:flutter/material.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map/map_state_proivders.dart';

class HideBookStoreButton extends ConsumerWidget {
  const HideBookStoreButton({Key? key}) : super(key: key);

  final double bRauius = 15;
  final Size size = const Size(80, 28);
  final double margin = 5;
  final double horiPadding = 12;
  final double vertPadding = 5;
  final Color grey = const Color(0xffdddddd);
  final TextStyle textStyle = const TextStyle(fontSize: 12);
  final double iconSize = 6;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ListType listType = ref.watch(listTypeProvider);
    final con = ref.read(listTypeProvider.notifier);
    final bool selected = listType == ListType.showHide;
    return GestureDetector(
        onTap: () => con.toggleShowHide(),
        child: Container(
          margin: EdgeInsets.all(margin),
          width: size.width,
          height: size.height,
          padding: EdgeInsets.symmetric(
              vertical: vertPadding, horizontal: horiPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: selected ? Colors.black : grey),
              borderRadius: BorderRadius.all(Radius.circular(bRauius))),
          child: Row(
            children: [
              Icon(
                Icons.abc,
                size: iconSize,
              ),
              Text(
                '숨은 서점',
                style: textStyle,
              ),
            ],
          ),
        ));
  }
}
