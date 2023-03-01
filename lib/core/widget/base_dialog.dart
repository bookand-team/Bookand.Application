import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_strings.dart';

class BaseDialog extends StatelessWidget {
  final bool isTwoBtn;
  final String negativeBtnText;
  final String positiveBtnText;
  final Function()? onTapNegativeBtn;
  final Function()? onTapPositiveBtn;
  final EdgeInsets? insetPadding;
  final EdgeInsets? padding;
  final Widget content;

  const BaseDialog({
    Key? key,
    this.isTwoBtn = false,
    this.negativeBtnText = AppStrings.close,
    this.positiveBtnText = AppStrings.ok,
    this.onTapNegativeBtn,
    this.onTapPositiveBtn,
    this.insetPadding,
    this.padding,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: insetPadding,
      child: Padding(
        padding: padding ??
            const EdgeInsets.only(
              left: 17,
              right: 17,
              top: 31,
              bottom: 21,
            ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            content,
            const SizedBox(
              height: 33,
            ),
            isTwoBtn
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: onTapNegativeBtn ?? context.pop,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDDDDDD),
                          foregroundColor: Colors.grey,
                          surfaceTintColor: const Color(0xFFDDDDDD),
                          fixedSize: const Size(128, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          negativeBtnText,
                          style: const TextStyle(
                            color: Color(0xFF222222),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: -0.04,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: onTapPositiveBtn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.grey,
                          surfaceTintColor: Colors.black,
                          fixedSize: const Size(128, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          positiveBtnText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: -0.04,
                          ),
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: onTapPositiveBtn ?? context.pop,
                    child: Text(
                      positiveBtnText,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
