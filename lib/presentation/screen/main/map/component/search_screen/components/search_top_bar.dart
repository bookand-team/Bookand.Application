//provider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchTopBar extends ConsumerWidget {
  final TextEditingController controller;
  final void Function(String value) onChanged;
  final void Function(String value) onSubmitted;
  final void Function() onFieldFocus;
  final FocusNode focusNode;

  SearchTopBar(
      {Key? key,
      required this.focusNode,
      required this.controller,
      required this.onFieldFocus,
      required this.onChanged,
      required this.onSubmitted})
      : super(key: key);

  final double bRadius = 8;
  final double padding = 10;
  final Color greyColor = const Color(0xffacacac);
  final Color thinGreyColor = const Color(0xfff5f5f5);

  static const double height = 50;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: thinGreyColor)),
      ),
      width: MediaQuery.of(context).size.width,
      height: height,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
          Expanded(
            child: Focus(
              onFocusChange: (value) {
                if (value) {
                  onFieldFocus();
                }
              },
              child: TextField(
                focusNode: focusNode,
                controller: controller,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                decoration: const InputDecoration.collapsed(
                    hintText: '궁금한 서점/지역을 검색해 보세요'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.clear();
            },
            child: Icon(
              Icons.cancel,
              color: greyColor,
            ),
          )
        ],
      ),
    );
  }
}
