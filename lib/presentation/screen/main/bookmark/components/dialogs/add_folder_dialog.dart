import 'package:bookand/core/widget/slide_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddFolderDialog extends StatefulWidget {
  final void Function(String name) onAdd;
  const AddFolderDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<AddFolderDialog> createState() => _AddFolderDialogState();
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
  bool isTaped = false;
  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width * 0.95;
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: br, topRight: br)),
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
            onTap: () {
              if (isActive) {
                if (!isTaped) {
                  isTaped = true;
                  widget.onAdd(controller.text);
                  context.pop();
                }
              }
            },
            child: Container(
              width: widgetWidth,
              height: buttonHeight,
              decoration: BoxDecoration(
                  color: isActive ? activeColor : deactiveColor,
                  borderRadius: BorderRadius.all(br)),
              child: Center(
                child: Text('추가',
                    style: titleStyel.copyWith(
                        color: isActive ? activeTextColor : deactiveTextColor)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
