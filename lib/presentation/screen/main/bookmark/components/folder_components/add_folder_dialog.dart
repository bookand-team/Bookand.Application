import 'package:bookand/core/widget/slide_icon.dart';
import 'package:flutter/material.dart';

class AddFolderDialog extends StatefulWidget {
  const AddFolderDialog({Key? key}) : super(key: key);

  @override
  _AddFolderDialogState createState() => _AddFolderDialogState();
}

class _AddFolderDialogState extends State<AddFolderDialog> {
  final TextEditingController controller = TextEditingController();
  final Radius br = const Radius.circular(10);

  final TextStyle titleStyel = const TextStyle(fontSize: 18);
  final double buttonHeight = 48;
  final double textFieldHeight = 60;
  final Size clearIconPadding = const Size(2, 8);

  final EdgeInsets dialogPadding = const EdgeInsets.fromLTRB(16, 4, 16, 16);

  final Color activeColor = const Color(0xff222222);
  final Color activeTextColor = const Color(0xffffffff);
  final Color deactiveColor = const Color(0xffeeeeee);
  final Color deactiveTextColor = const Color(0xff999999);

  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width * 0.95;
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: br, topRight: br),
      ),
      child: Container(
        width: double.maxFinite,
        padding: dialogPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            slideIconTop,
            Text(
              '새 폴더 추가',
              style: titleStyel,
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              width: widgetWidth,
              height: textFieldHeight,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: widgetWidth,
                      height: textFieldHeight,
                      child: TextField(
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            if (controller.text.isNotEmpty) {
                              isActive = true;
                            } else {
                              isActive = false;
                            }
                          });
                        },
                        controller: controller,
                        maxLength: 7,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: deactiveColor)),
                          hintText: '폴더명 입력',
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: deactiveColor)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: clearIconPadding.height,
                    right: clearIconPadding.width,
                    child: GestureDetector(
                        onTap: () {
                          controller.clear();
                          setState(() {
                            isActive = false;
                          });
                        },
                        child: Icon(
                          Icons.cancel,
                          color: deactiveTextColor,
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: widgetWidth,
                height: buttonHeight,
                decoration: BoxDecoration(
                    color: isActive ? activeColor : deactiveColor,
                    borderRadius: BorderRadius.all(br)),
                child: Center(
                  child: Text('추가',
                      style: titleStyel.copyWith(
                          color:
                              isActive ? activeTextColor : deactiveTextColor)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
