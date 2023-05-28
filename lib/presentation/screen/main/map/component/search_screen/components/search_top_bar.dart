//provider
import 'package:bookand/presentation/provider/map/bools/map_search_out_toggle.dart.dart';
import 'package:bookand/presentation/provider/map/map_search_stores_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchTopBar extends ConsumerStatefulWidget {
  const SearchTopBar({Key? key}) : super(key: key);

  @override
  _SearchTopBarState createState() => _SearchTopBarState();
}

class _SearchTopBarState extends ConsumerState<SearchTopBar> {
  final double bRadius = 8;
  final double padding = 10;
  final Color greyColor = const Color(0xffacacac);
  final Color thinGreyColor = const Color(0xfff5f5f5);

  final Size size = const Size(320, 50);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final search = ref.read(mapSearchPageSearchedProvider);
    final searchCon = ref.read(mapSearchPageSearchedProvider.notifier);

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: thinGreyColor)),
      ),
      width: MediaQuery.of(context).size.width,
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
              controller: controller,
              onChanged: (value) {
                ref
                    .read(mapSearchStoreNotifierProvider.notifier)
                    .searchTextChange(value);
              },
              onSubmitted: (value) {
                ref.read(mapSearchPageSearchedProvider.notifier).activate();
                ref
                    .read(widgetMarkerNotiferProvider.notifier)
                    .setBookstoreMarker(
                        ref.read(mapSearchStoreNotifierProvider));
              },
              decoration: const InputDecoration.collapsed(
                  hintText: '궁금한 서점/지역을 검색해 보세요'),
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
