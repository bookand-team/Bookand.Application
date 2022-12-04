import 'package:bookand/config/theme/custom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HashtagBox extends StatelessWidget {
  final String tag;

  const HashtagBox({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.8),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        tag,
        style: const TextStyle().hashtagText(),
      ),
    );
  }

}