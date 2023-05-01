import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/util/logger.dart';
import 'package:bookand/core/widget/slide_icon.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/provider/map/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_in_screen_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/map_panel_visible_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/book_store_tile.dart';
import 'package:bookand/presentation/screen/main/map/component/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/component/list_button.dart';
import 'package:bookand/presentation/screen/main/map/component/map_function_buttons.dart';
import 'package:bookand/presentation/screen/main/map/component/search_screen/components/recommendation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

///map에서 쓰일 중간 부분
class MapBody extends ConsumerStatefulWidget {
  final double panelMaxHeight;
  final double panelMinHeight;
  final Widget? topBar;
  final List<Widget> panelBody;
  final double initLat;
  final double initLon;
  final double initZoom;
  final Future Function()? getFutureData;
  final List<BookStoreMapModel>? datas;
  final bool isMain;

  ///화면 꽉 채울지 말지, 채우면 opne일 때 br 없앰
  final bool isfull;
  const MapBody(
      {Key? key,
      this.isMain = true,
      this.datas,
      this.topBar,
      this.initLat = SEOUL_COORD_LAT,
      this.initLon = SEOUL_COORD_LON,
      this.initZoom = 13,
      required this.panelBody,
      required this.panelMaxHeight,
      required this.panelMinHeight,
      required this.isfull,
      this.getFutureData})
      : super(key: key);

  @override
  _MapBodyState createState() => _MapBodyState();
}

class _MapBodyState extends ConsumerState<MapBody> {
  PanelController panelController = PanelController();
  late double maxHeight;
  late double minHeight;
  late double fixedMinHeight;
  late Widget? topBar;
  late List<Widget> panelBody;
  late CameraPosition initCamera;
  BorderRadius br = const BorderRadius.only(
      topLeft: Radius.circular(24), topRight: Radius.circular(24));
  // 버튼 하단, 오른쪽  패딩
  final double buttonPading = 15;
  //버튼 사이의 간격
  final double buttonSpace = 40;

  bool inited = false;
  bool panelIsUp = false;
  bool panelIsClose = false;
  bool panelIsSliding = false;
  bool showAppbar = true;
  double alpah = 0;
  @override
  void initState() {
    panelBody = widget.panelBody;
    maxHeight = widget.panelMaxHeight;
    minHeight = widget.panelMinHeight;
    fixedMinHeight = minHeight;
    topBar = widget.topBar;
    initCamera = CameraPosition(
        target: LatLng(widget.initLat, widget.initLon), zoom: widget.initZoom);
    ref
        .read(mapButtonHeightNotifierProvider.notifier)
        .initPanelHeight(minHeight);

    super.initState();
  }

  //패널 열렸을 때 핸들러
  void panelOpened() {
    setState(() {
      panelIsUp = true;
      panelIsClose = false;
      panelIsSliding = false;
    });
  }

//패널 닫혔을 때 핸들러
  void panelClosed() {
    setState(() {
      panelIsUp = false;
      panelIsClose = true;
      panelIsSliding = false;
      showAppbar = true;
    });
  }

  void panelSliding() {
    setState(() {
      panelIsUp = false;
      panelIsClose = false;
      panelIsSliding = true;
    });
  }

  void scrollListner() {
    if (panelIsClose) {
      alpah += 0.5;
    }
  }

  bool panelIsOpen() {
    if (panelController.isAttached) {
      return (panelController.panelPosition == 1);
    } else {
      return false;
    }
  }

  void showSearhBar() {
    if (!showAppbar) {
      setState(() {
        showAppbar = true;
      });
    }
  }

  void hideSearhBar() {
    if (showAppbar) {
      setState(() {
        showAppbar = false;
      });
    }
  }

  List<Widget> renderForMain(List<BookStoreMapModel> models) {
    if (models.isNotEmpty) {
      List<Widget> list = [];
      for (var element in models) {
        list.add(BookStoreTile(store: element));
      }
      list.add(const SizedBox(
        height: 60,
      ));
      return list;
    } else {
      return [
        const SizedBox(
          height: 30,
        ),
        const Icon(Icons.error_outline),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '근처에 서점이 없어요',
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '숨은 서점을 추천 받아 보세요!',
        ),
        const SizedBox(
          height: 10,
        ),
        RecommendationButton(
          onTap: () {
            ref.read(mapPanelVisibleNotifierProvider.notifier).deactivate();
            ref
                .read(hideStoreToggleProvider.notifier)
                .activate(context: context, ref: ref);
          },
        ),
        const SizedBox(
          height: 30,
        ),
      ];
    }
  }

  List<BookStoreMapModel>? forMain;
  bool isFull = true;
  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = ref.watch(widgetMarkerNotiferProvider);

    final mapControllerCon = ref.read(mapControllerNotiferProvider.notifier);
    // button height riverpod
    final buttonHeightCon = ref.read(mapButtonHeightNotifierProvider.notifier);

    final showList = ref.watch(mapPanelVisibleNotifierProvider);
    if (showList) {
      if (minHeight == 0) {
        minHeight = widget.panelMinHeight;
      }
      fixedMinHeight = minHeight;
    } else {
      fixedMinHeight = 0;
    }

    double buttonHeight =
        fixedMinHeight + ref.watch(mapButtonHeightNotifierProvider);

    //꽉 찰 수도 있을 때
    if (widget.isMain) {
      forMain = ref.watch(mapInScreenBookStoreNotifierProvider);
      if (forMain!.isNotEmpty) {
        maxHeight = forMain!.length * BookStoreTile.height;
      } else {
        maxHeight = BookStoreTile.height;
      }
      if (buttonHeight > maxHeight) {
        // buttonHeight = maxHeight;
      }
      if (maxHeight < MediaQuery.of(context).size.height * 0.9) {
        isFull = false;
      }
    }
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SlidingUpPanel(
            controller: panelController,
            boxShadow: const [],
            //오픈되면 radius 삭제,isfull아니면 그대로 유지
            borderRadius: panelIsUp ? (isFull ? null : br) : br,
            maxHeight: maxHeight,
            minHeight: fixedMinHeight,
            onPanelOpened: () {
              panelOpened();
              buttonHeightCon.updateHeight(maxHeight);
            },
            onPanelSlide: (position) {
              double height = (maxHeight - minHeight) * position;
              buttonHeightCon.updateHeight(height);
            },
            onPanelClosed: () {
              buttonHeightCon.toBottom();
              panelClosed();
            },
            //패널 시작
            panelBuilder: (sc) {
              //펼친 상태에서 스크롤 방향에 따라 검색 바 출력할지 판단
              if (sc.hasClients) {
                sc.addListener(() {
                  if (isFull) {
                    if (panelIsOpen()) {
                      ScrollDirection scrollDirection =
                          sc.position.userScrollDirection;
                      if (scrollDirection == ScrollDirection.forward) {
                        showSearhBar();
                      } else {
                        hideSearhBar();
                      }
                    }
                  }
                });
              }

              return GestureDetector(
                // behavior: HitTestBehavior.translucent,
                //close일 때 + panel show 일 때 아래 슬라이딩 감지 후 닫기
                onPanStart: (details) {},
                onPanUpdate: (details) {
                  if (panelController.panelPosition == 0 &&
                      details.delta.dy > 0) {
                    setState(() {
                      minHeight += -details.delta.dy;
                    });
                  }
                },
                onPanEnd: (details) {
                  logger.d(minHeight);
                  if (minHeight < 150) {
                    setState(() {
                      minHeight = 0;
                    });
                    ref
                        .read(mapPanelVisibleNotifierProvider.notifier)
                        .deactivate();
                    logger.d(minHeight);
                  } else {
                    minHeight = widget.panelMinHeight;
                  }
                },

                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      slideIcon,
                      Expanded(
                        child: SingleChildScrollView(
                          controller: sc,
                          // close일 때는 scroll 감지 안되게
                          physics:
                              (panelController.panelPosition == 0 || !isFull)
                                  ? const NeverScrollableScrollPhysics()
                                  : null,

                          child: Column(
                            children: widget.isMain
                                ? renderForMain(forMain!)
                                : panelBody,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            //패널 끝

            body: GoogleMap(
                onTap: (argument) {
                  ref.read(widgetMarkerNotiferProvider.notifier).setAllNormal();
                },
                zoomControlsEnabled: false,
                onMapCreated: (controller) {
                  mapControllerCon.initController(controller);
                },
                markers: markers,
                initialCameraPosition: initCamera),
          ),
        ),
        showAppbar
            ? Align(
                alignment: Alignment.topCenter,
                child: topBar,
              )
            : const SizedBox(),
        //떠있는 버튼들 시작
        Positioned(
            right: buttonPading,
            bottom: buttonHeight + buttonSpace + buttonPading,
            child: ListButton(
              onAcitve: () async {
                if (widget.getFutureData != null) {
                  await widget.getFutureData!();
                  setState(() {});
                }
              },
              onDeactive: () {},
            )),
        Positioned(
            right: buttonPading,
            bottom: buttonHeight + buttonPading,
            child: GpsButton()),
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
        //떠있는 버튼들 끝
      ],
    );
  }
}
