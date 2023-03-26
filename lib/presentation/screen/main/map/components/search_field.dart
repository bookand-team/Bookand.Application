import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  final double bRadius = 8;
  final double padding = 10;
  final Color greyColor = const Color(0xffacacac);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.all(Radius.circular(bRadius))),
      width: 320,
      child: Row(
        children: [
          Expanded(
            child: const TextField(
              decoration:
                  InputDecoration.collapsed(hintText: '궁금한 서점/지역을 검색해 보세요'),
            ),
          ),
          GestureDetector(
            child: Icon(
              Icons.search,
              color: greyColor,
            ),
          )
        ],
      ),
    );
  }
}
