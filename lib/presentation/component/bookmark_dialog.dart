import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showConfirmDialog({
  required BuildContext context,
  String? title,
  String? description,
  required String leftButtonString,
  required String rightButtonString,
  required void Function() onLeftButtonTap,
  required void Function() onRightButtonTap,
  bool rightIsImportant = true,
}) {
  showDialog(
    context: context,
    builder: (context) => BookmarkDialog(
        title: title,
        description: description,
        leftButtonString: leftButtonString,
        rightButtonString: rightButtonString,
        rightIsImportant: rightIsImportant,
        onLeftButtonTap: onLeftButtonTap,
        onRightButtonTap: onRightButtonTap),
  );
}

class BookmarkDialog extends ConsumerWidget {
  final String? title;
  final String? description;
  final String leftButtonString;
  final String rightButtonString;
  final bool rightIsImportant;
  final void Function() onLeftButtonTap;
  final void Function() onRightButtonTap;
  const BookmarkDialog({
    Key? key,
    this.title,
    this.description,
    required this.leftButtonString,
    required this.rightButtonString,
    required this.onLeftButtonTap,
    required this.onRightButtonTap,
    this.rightIsImportant = true,
  }) : super(key: key);

  final TextStyle contentStyle = const TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    letterSpacing: -0.60,
  );

  final Radius containerBr = const Radius.circular(18);
  final Radius buttonBr = const Radius.circular(8);

  final Color grey = const Color(0xffdddddd);

  final Size size = const Size(300, 220);
  final Size buttonSize = const Size(128, 40);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(containerBr)),
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 48, right: 30, left: 30, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (title != null)
                    Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.36,
                      ),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (description != null)
                    Text(
                      description ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 15,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      onLeftButtonTap();
                    },
                    child: Container(
                      width: buttonSize.width,
                      height: buttonSize.height,
                      decoration: BoxDecoration(
                          color: rightIsImportant ? grey : Colors.black,
                          borderRadius: BorderRadius.all(buttonBr)),
                      child: Center(
                        child: Text(
                          leftButtonString,
                          style: contentStyle.copyWith(
                              color: rightIsImportant
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      onRightButtonTap();
                    },
                    child: Container(
                      width: buttonSize.width,
                      height: buttonSize.height,
                      decoration: BoxDecoration(
                          color: rightIsImportant ? Colors.black : grey,
                          borderRadius: BorderRadius.all(buttonBr)),
                      child: Center(
                        child: Text(
                          rightButtonString,
                          style: contentStyle.copyWith(
                              color: rightIsImportant
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
