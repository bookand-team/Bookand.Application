import 'package:bookand/core/const/asset_path.dart';
import 'package:flutter/material.dart';

class BookMarkButton extends StatefulWidget {
  const BookMarkButton({Key? key}) : super(key: key);

  @override
  _BookMarkButtonState createState() => _BookMarkButtonState();
}

class _BookMarkButtonState extends State<BookMarkButton> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        child: isSelected
            ? const Image(image: AssetImage(bookmarkActivatePath))
            : const Image(image: AssetImage(bookmarkDeactivatePath)),
      ),
    );
  }
}
