import 'package:bookand/core/widget/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';

//components
import 'package:bookand/presentation/component/map/search_page/book_store_searched_tile.dart';
import 'package:bookand/presentation/component/map/search_page/no_search_text.dart';
import 'package:bookand/presentation/component/map/search_page/recommendation_button.dart';
import 'package:bookand/presentation/component/map/search_page/top_bar.dart';

class MapSearchScreen extends ConsumerWidget {
  static String get routeName => 'mapSearch';
  const MapSearchScreen({Key? key}) : super(key: key);
  final double slideBraidus = 24;

  // init camera
  static const initCamera =
      CameraPosition(target: LatLng(37.5665, 126.9780), zoom: 13);

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
    final search = ref.watch(searchToggleProvider);
    final searchCon = ref.read(searchToggleProvider.notifier);

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
              const TopBar(),
              TextButton(
                  onPressed: () {
                    searchCon.toggle();
                  },
                  child: const Text('test')),
              const BookStoreSearchedTile(),
              ...getBody(search, GoogleMap(initialCameraPosition: initCamera))
            ]),
          ),
        ),
      ),
    );
  }
}
