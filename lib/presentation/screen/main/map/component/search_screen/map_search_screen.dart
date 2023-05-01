import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/provider/map/map_search_stores_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/map_body.dart';
import 'package:bookand/presentation/screen/main/map/component/search_screen/components/search_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//components
import 'components/book_store_searched_tile.dart';
import 'components/no_search_text.dart';
import 'components/recommendation_button.dart';

class MapSearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'mapSearch';
  const MapSearchScreen({Key? key}) : super(key: key);

  @override
  _MapSearchScreenState createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends ConsumerState<MapSearchScreen> {
  late List<BookStoreMapModel> searchedList;
  bool isSearched = false;

  final TextEditingController searchTextCon = TextEditingController();

  double searchInterval = 0;
  final double constInterval = 0.5;

  final double slideBraidus = 24;
  // init camera
  CameraPosition initCamera =
      const CameraPosition(target: LatLng(37.5665, 126.9780), zoom: 13);

  @override
  void initState() {
    super.initState();
  }

  Widget searchingPage(List<BookStoreMapModel> searchedList) {
    return searchedList.isEmpty
        ? Column(children: [
            Spacer(),
            NoSearchText(),
            Spacer(),
            RecommendationButton(
              onTap: () {},
            ),
            SizedBox(
              height: 40,
            )
          ])
        : Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: searchedList
                      .map((e) => BookStoreSearchedTile(
                            model: e,
                          ))
                      .toList(),
                ),
              )),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark));

    searchedList = ref.watch(mapSearchStoreNotifierProvider);
    // is searched
    isSearched = ref.watch(mapSearchPageSearchedProvider);
    final searchCon = ref.read(mapSearchPageSearchedProvider.notifier);
    if (searchedList.isNotEmpty) {
      final nearStore = searchedList.first;
      initCamera = CameraPosition(
          target: LatLng(nearStore.latitude!, nearStore.longitude!), zoom: 13);
    }

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: BaseLayout(
          onWillPop: () async {
            if (isSearched) {
              searchCon.toggle();
              return Future(() => false);
            } else {
              // ref.context.pop();
              return true;
            }
          },
          child: Column(
            children: [
              SearchTopBar(),
              Expanded(
                  child: isSearched
                      ? MapBody(
                          initLat: initCamera.target.latitude,
                          initLon: initCamera.target.longitude,
                          panelBody: searchedList
                              .map((e) => BookStoreSearchedTile(model: e))
                              .toList(),
                          panelMaxHeight:
                              MediaQuery.of(context).size.height * 0.85,
                          panelMinHeight: 250,
                          isfull: false)
                      : searchingPage(searchedList))
            ],
          ),
        ),
      ),
    );
  }
}
