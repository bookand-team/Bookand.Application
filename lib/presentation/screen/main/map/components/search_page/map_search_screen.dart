import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/provider/map_provider.dart';
import 'package:bookand/presentation/provider/map_state_proivders.dart';
import 'package:bookand/presentation/screen/main/map/components/search_page/components/book_store_searched_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
//components
import 'components/no_search_text.dart';
import 'components/recommendation_button.dart';
import 'components/search_field.dart';

class MapSearchScreen extends ConsumerWidget {
  static String get routeName => 'mapSearch';
  const MapSearchScreen({Key? key}) : super(key: key);
  final double slideBraidus = 24;

  List<Widget> getBody(bool condition, Widget body) {
    return !condition
        ? [
            const Spacer(),
            const NoSearchText(),
            const Spacer(),
            const RecommendationButton(),
            const SizedBox(
              height: 40,
            )
          ]
        : [
            Expanded(
              child: SlidingUpPanel(
                boxShadow: const [],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(slideBraidus),
                    topRight: Radius.circular(slideBraidus)),
                panelBuilder: (sc) => Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 60,
                      height: 2,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: sc,
                        child: Column(
                          children: const [
                            BookStoreSearchedTile(),
                            BookStoreSearchedTile(),
                            BookStoreSearchedTile(),
                            BookStoreSearchedTile(),
                            BookStoreSearchedTile(),
                            BookStoreSearchedTile(),
                            BookStoreSearchedTile(),
                            BookStoreSearchedTile(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                body: body,
              ),
            )
          ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(searchProvider);
    final searchCon = ref.read(searchProvider.notifier);
    final MyMap myMap = ref.read(myMapProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: BaseLayout(
          onWillPop: () async {
            if (search) {
              searchCon.toggle();
              return Future(() => false);
            } else {
              // ref.context.pop();
              return true;
            }
          },
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              const SearchField(),
              TextButton(
                  onPressed: () {
                    searchCon.toggle();
                  },
                  child: const Text('test')),
              const BookStoreSearchedTile(),
              ...getBody(search, myMap.googleMap)
            ]),
          ),
        ),
      ),
    );
  }
}