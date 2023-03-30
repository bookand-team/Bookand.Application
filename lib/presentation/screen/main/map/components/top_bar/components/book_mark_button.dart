import 'package:bookand/presentation/provider/map_state_proivders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookMarkButton extends ConsumerWidget {
  const BookMarkButton({Key? key}) : super(key: key);

  final double bRauius = 15;
  final Size size = const Size(55, 28);
  final double margin = 5;
  final double horiPadding = 12;
  final double vertPadding = 5;
  final Color grey = const Color(0xffdddddd);
  final TextStyle textStyle = const TextStyle(fontSize: 12);
  final Color selectedColor = const Color(0xfff86c30);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(bookMarkToggleProvider);
    final con = ref.read(bookMarkToggleProvider.notifier);

    return GestureDetector(
        onTap: () => con.toggle(),
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
          child: Text(
            '북마크',
            style: textStyle.copyWith(color: selected ? selectedColor : null),
          ),
        ));
  }
}
