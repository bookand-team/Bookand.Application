import 'package:flutter/material.dart';
import 'search_field.dart';
import 'search_buttons/search_buttons.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 108,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SearchField(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const MarkButton(),
              const ThemeButton(),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(10),
                width: 1,
                height: 16,
                color: const Color(0xffdddddd),
              ),
              const HideBookStoreButton()
            ],
          )
        ],
      ),
    );
  }
}
