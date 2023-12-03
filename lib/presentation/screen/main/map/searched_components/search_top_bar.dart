//provider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../gen/assets.gen.dart';

class SearchTopBar extends ConsumerWidget {
  final TextEditingController controller;
  final void Function(String value) onChanged;
  final void Function(String value) onSubmitted;
  final void Function() onFieldFocus;
  final FocusNode focusNode;

  const SearchTopBar(
      {Key? key,
      required this.focusNode,
      required this.controller,
      required this.onFieldFocus,
      required this.onChanged,
      required this.onSubmitted})
      : super(key: key);

  final double bRadius = 8;
  final Color greyColor = const Color(0xffacacac);
  final Color thinGreyColor = const Color(0xfff5f5f5);

  static const double height = 50;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            child: SvgPicture.asset(
              Assets.images.map.icSearchingBack,
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(
            width: 2,
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
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: -0.30,
                ),
                decoration: const InputDecoration(
                    isCollapsed: true,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Color(0xFFACACAC),
                      fontSize: 15,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.30,
                    ),
                    hintText: '궁금한 서점/지역을 검색해 보세요'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.clear();
            },
            child: SvgPicture.asset(
              Assets.images.map.icSearchingDelete,
              width: 16,
              height: 16,
            ),
          )
        ],
      ),
    );
  }
}
