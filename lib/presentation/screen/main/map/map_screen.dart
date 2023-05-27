import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/geolocator_position_provider.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_filtered_book_store_provider.dart';
import 'package:bookand/presentation/provider/map/map_in_screen_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/map_body.dart';
import 'package:bookand/presentation/screen/main/map/component/top_bar/top_bar.dart';
import 'package:flutter/material.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widget/base_layout.dart';
//components
import 'component/book_store_tile.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

enum CustomPanelState { opend, closed }

class _MapScreenState extends ConsumerState<MapScreen> {
  //textstyles

  bool inited = false;

  //서버에서 받은 모든 bookstroes
  List<BookStoreMapModel> bookstores = [];
  //조건 처리된 bookstores
  List<BookStoreMapModel> filteredBookstroes = [];
  //현재 화면 안에 있는 bookstores
  List<BookStoreMapModel> bookstoresInScreen = [];

  @override
  void initState() {
    init();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//bookstore를 서버에서 받고 초기화 후 마커 출력
  Future init() async {
    final userCoord = await ref
        .read(gelolocatorPostionNotifierProvider.notifier)
        .getCurrentPosition();
    //카메라 이동
    ref
        .read(mapControllerNotiferProvider.notifier)
        .moveCamera(lat: userCoord.lat, lng: userCoord.lng);
    // 서버에서 받음.
    await ref
        .read(mapBookStoreNotifierProvider.notifier)
        .fetchBookstoreList(userLat: userCoord.lat, userLon: userCoord.lng);
    // bookstores 초기화
    bookstores = ref.read(mapBookStoreNotifierProvider);
    // filteredbookstores 초기화
    ref
        .read(mapFilteredBookStoreNotifierProvider.notifier)
        .filteredBookstroes(isBookmark: false, selectedThemes: []);
    filteredBookstroes = ref.read(mapFilteredBookStoreNotifierProvider);
    //마커 출력
    ref
        .read(widgetMarkerNotiferProvider.notifier)
        .initMarkers(filteredBookstroes, context);
    inited = true;
  }

  @override
  Widget build(BuildContext context) {
    List<BookStoreMapModel> inScreen =
        ref.watch(mapInScreenBookStoreNotifierProvider);

    return BaseLayout(
        child: MapBody(
      getFutureData: ref
          .read(mapInScreenBookStoreNotifierProvider.notifier)
          .fetchInScreenBookstore,
      topBar: const TopBar(),
      panelBody: inScreen.map((e) => BookStoreTile(store: e)).toList(),
      panelMaxHeight: MediaQuery.of(context).size.height,
      panelMinHeight: 300,
      isfull: true,
    ));
  }
}
