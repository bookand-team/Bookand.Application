// ignore_for_file: use_build_context_synchronously

import 'package:bookand/presentation/component/bookmark_dialog.dart';
import 'package:bookand/presentation/provider/bookmark/main_ref_provider.dart';
import 'package:bookand/presentation/provider/map/bools/map_search_bar_toggle.dart';
import 'package:bookand/presentation/provider/map/geolocator_permission_provider.dart';
import 'package:bookand/presentation/provider/map/geolocator_position_provider.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/map_body.dart';
import 'package:bookand/presentation/screen/main/map/component/top_bar/map_bar_long.dart';
import 'package:bookand/presentation/screen/main/map/component/top_bar/map_bar_short.dart';
import 'package:flutter/material.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/widget/base_layout.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

enum CustomPanelState { opend, closed }

class _MapScreenState extends ConsumerState<MapScreen> {
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
    WidgetRef? safeRef = ref.read(mainRefNotifierProvider);
    if (safeRef == null) {
      return;
    }
    // 서버에서 받고 마커 출력
    if (!ref.read(mapBookStoreNotifierProvider.notifier).inited) {
      safeRef.read(mapBookStoreNotifierProvider.notifier).initBookStores().then(
          (value) => safeRef
              .read(widgetMarkerNotiferProvider.notifier)
              .initMarkers(value, context));
    }

    //유저 좌표 확인 및 유저와의 거리 추가
    bool isGranted = await safeRef
        .read(geolocaotorPermissionNotifierProvider.notifier)
        .getPermission();
    if (isGranted) {
      final userCoord = await safeRef
          .read(gelolocatorPostionNotifierProvider.notifier)
          .getCurrentPosition();
      safeRef
          .read(mapBookStoreNotifierProvider.notifier)
          .patchStoresDistanceBetweenUser(
              userLat: userCoord.latitude, userLon: userCoord.longitude);
    } else {
      await showDialog(
          context: context,
          builder: (context) => BookmarkDialog(
                title: 'Gsp 권한 설정',
                description: '해당 기능을 사용하기 위해선 Gps 권한 설정이 필요합니다.',
                leftButtonString: '취소',
                rightButtonString: '설정',
                onLeftButtonTap: () {},
                onRightButtonTap: () {
                  Geolocator.openAppSettings();
                },
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool searchBarShow = ref.watch(mapSearchBarToggleNotifierProvider);
    return BaseLayout(
        appBar: searchBarShow
            ? const MapBarLong() as PreferredSizeWidget
            : const MapBarShort(),
        child: const MapBody());
  }
}
