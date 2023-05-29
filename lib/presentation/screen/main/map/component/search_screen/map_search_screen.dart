import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/bools/map_search_out_toggle.dart.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_search_stores_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/component/list_button.dart';
import 'package:bookand/presentation/screen/main/map/component/map_function_buttons.dart';
import 'package:bookand/presentation/screen/main/map/component/search_screen/components/search_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

  final double buttonPading = 15;
  final double buttonSpace = 40;
  @override
  void initState() {
    super.initState();
  }

  Widget searchingPage(List<BookStoreMapModel> searchedList) {
    return Container(
      color: Colors.white,
      child: searchedList.isEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  const Spacer(),
                  const NoSearchText(),
                  const Spacer(),
                  RecommendationButton(
                    onTap: () {
                      ref.context.pop('showhide');
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ]),
              ],
            )
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
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark));

    searchedList = ref.watch(mapSearchStoreNotifierProvider);
    // is searched
    isSearched = ref.watch(mapSearchPageSearchedNotifierProvider);
    final searchCon = ref.read(mapSearchPageSearchedNotifierProvider.notifier);
    if (searchedList.isNotEmpty) {
      final nearStore = searchedList.first;
      initCamera = CameraPosition(
          target: LatLng(nearStore.latitude ?? SEOUL_COORD_LAT,
              nearStore.longitude ?? SEOUL_COORD_LON),
          zoom: 13);
    }

    double buttonHeight = ref.watch(mapButtonHeightNotifierProvider);

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
          child: Stack(
            children: [
              GoogleMap(
                  onTap: (argument) {
                    ref
                        .read(widgetMarkerNotiferProvider.notifier)
                        .setAllNormal();
                  },
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) {
                    ref
                        .read(mapControllerNotiferProvider.notifier)
                        .initController(controller);
                  },
                  markers: ref.watch(widgetMarkerNotiferProvider),
                  initialCameraPosition: initCamera),
              Positioned(
                  right: buttonPading,
                  bottom: buttonHeight + buttonSpace + buttonPading,
                  child: ListButton(
                    onAcitve: () async {},
                    onDeactive: () {},
                  )),
              Positioned(
                  right: buttonPading,
                  bottom: buttonHeight + buttonPading,
                  child: GpsButton(
                    onAcitve: () {},
                    onDeactive: () {},
                  )),
              Positioned(
                right: buttonPading,
                bottom: buttonHeight + buttonPading + 2 * buttonSpace,
                child: const MapZoomOutButton(),
              ),
              Positioned(
                right: buttonPading,
                bottom: buttonHeight + buttonPading + 3 * buttonSpace,
                child: const MapZoomInButton(),
              ),
              isSearched ? const SizedBox() : searchingPage(searchedList),
              const Align(
                alignment: Alignment.topCenter,
                child: SearchTopBar(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
