import 'package:bookand/core/theme/custom_text_style.dart';
import 'package:flutter/material.dart';

import '../../core/theme/color_table.dart';

class RoundRectButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Function() onPressed;
  final bool enabled;

  const RoundRectButton(
      {super.key,
      required this.text,
      required this.width,
      required this.height,
      required this.onPressed,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
            fixedSize: Size(width, height),
            backgroundColor: lightColorFF222222,
            foregroundColor: enabled ? Colors.white10 : Colors.transparent,
            disabledBackgroundColor: lightColorFFDDDDDD,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        child: Text(
          text,
          style: const TextStyle().roundRectButtonText(enabled: enabled),
        ));
  }
}
