import 'package:flutter/material.dart';

class NoSearchText extends StatelessWidget {
  const NoSearchText({Key? key}) : super(key: key);

  final TextStyle medium = const TextStyle();
  final TextStyle small = const TextStyle();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline),
        Text(
          '검색 결과가 없어요',
          style: medium,
        ),
        Text(
          '검색어를 수정하거나 숨은 서점을 추천 받아 보세요!',
          style: small,
        )
      ],
    );
  }
}
