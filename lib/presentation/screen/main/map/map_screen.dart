import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/bools/map_search_bar_toggle.dart';
import 'package:bookand/presentation/provider/map/geolocator_position_provider.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_filtered_book_store_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/map_body.dart';
import 'package:bookand/presentation/screen/main/map/component/top_bar/map_bar_long.dart';
import 'package:bookand/presentation/screen/main/map/component/top_bar/map_bar_short.dart';
import 'package:flutter/material.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widget/base_layout.dart';

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

  BorderRadius panelBr = const BorderRadius.only(
      topLeft: Radius.circular(24), topRight: Radius.circular(24));

  final double buttonPading = 15;
  //버튼 사이의 간격
  final double buttonSpace = 40;

  bool listScrollEnable = false;

  // 패널이 열렸을 때 br, slideicon 조정
  bool panelOpend = false;
  // 패널이 완전히 닫혔을 때, 이 때 밑으로 슬라이딩 하면 꺼지게
  bool panelClosed = false;
  // bookstore갯수가 화면을 덮을 정도로 많으면, 3개 이상
  bool isFull = false;
  // 패널이 닫혀있을 때 아래로 슬라이딩 몇 초 하는 지
  DateTime downStartTime = DateTime.now();
  DateTime downEndTime = DateTime.now();
  int slideTime = 0;

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
    bool searchBarShow = ref.watch(mapSearchBarToggleProvider);
    return BaseLayout(
        appBar: searchBarShow
            ? const MapBarLong() as PreferredSizeWidget
            : const MapBarShort(),
        child: const MapBody());
  }
}
