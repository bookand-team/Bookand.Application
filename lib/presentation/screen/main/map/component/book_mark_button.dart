import 'package:bookand/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookMarkButton extends StatefulWidget {
  final bool acitve;
  final void Function() onAcive;
  final void Function() onDisactive;
  const BookMarkButton(
      {Key? key,
      required this.acitve,
      required this.onAcive,
      required this.onDisactive})
      : super(key: key);

  @override
  _BookMarkButtonState createState() => _BookMarkButtonState();
}

class _BookMarkButtonState extends State<BookMarkButton> {
  late bool isSelected;
  late bool widgetState;
  @override
  void initState() {
    isSelected = widget.acitve;
    widgetState = widget.acitve;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widgetState != widget.acitve) {
      isSelected = widget.acitve;
    }
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          widget.onDisactive();
        } else {
          widget.onAcive();
        }
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        child: isSelected
            ? SvgPicture.asset(Assets.images.map.bookmarkActive)
            : SvgPicture.asset(Assets.images.map.bookmarkDeactive),
      ),
    );
  }
}
