//providers
import 'package:flutter/material.dart';

import '../../../../core/const/map.dart';

class MapAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLong;
  final Widget searchButton;
  final List<Widget> bottomButtons;

  const MapAppBar(
      {Key? key,
      required this.isLong,
      required this.searchButton,
      required this.bottomButtons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
      // height: 108,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          isLong ? searchButton : const SizedBox(),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: bottomButtons,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity,
      isLong ? MAP_APPBAR_LONG_HEIGHT : MAP_APPBAR_SHORT_HEIGHT);
}
