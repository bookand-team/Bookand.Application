import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
//provider
import 'package:bookand/presentation/provider/map/map_state_proivders.dart';

class TopBar extends ConsumerWidget {
  const TopBar({Key? key}) : super(key: key);

  final double bRadius = 8;
  final double padding = 10;
  final Color greyColor = const Color(0xffacacac);
  final Color thinGreyColor = const Color(0xfff5f5f5);

  final Size size = const Size(320, 50);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.read(searchProvider);
    final searchCon = ref.read(searchProvider.notifier);

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: thinGreyColor)),
      ),
      width: size.width,
      height: size.height,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (search) {
                searchCon.toggle();
              } else {
                ref.context.pop();
              }
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
          Expanded(
            child: TextField(
              onSubmitted: (value) {},
              decoration: const InputDecoration.collapsed(
                  hintText: '궁금한 서점/지역을 검색해 보세요'),
            ),
          ),
          GestureDetector(
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
