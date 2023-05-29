//북마크 버튼에 따라 토글되는 state
import 'package:bookand/core/widget/slide_icon.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/component/bookstore_snackbar.dart';
import 'package:bookand/presentation/provider/map/bools/map_hidestore_toggle.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_list_toggle.dart';
import 'package:bookand/presentation/provider/map/map_body_key_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/book_store_tile.dart';
import 'package:bookand/presentation/screen/main/map/component/top_bar/components/hide_book_store_bottom_sheet.dart';
import 'package:bookand/presentation/screen/main/map/component/top_bar/map_bar_long.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapBottomSheetControllerNotifier
    extends StateNotifier<PersistentBottomSheetController?> {
  late MapButtonHeightNotifier buttonHeightCon;
  late MapListToggle listToggleCon;
  late HideStoreToggleNotifier hideToggleCon;
  late WidgetMarkerNotifer markerCon;
  late GlobalKey bodyKey;

  MapBottomSheetControllerNotifier(StateNotifierProviderRef ref) : super(null) {
    buttonHeightCon = ref.read(mapButtonHeightNotifierProvider.notifier);
    listToggleCon = ref.read(mapListToggleProvider.notifier);
    hideToggleCon = ref.read(hideStoreToggleNotifierProvider.notifier);
    markerCon = ref.read(widgetMarkerNotiferProvider.notifier);
    bodyKey = ref.read(mapBodyKeyProvider);
  }

  EdgeInsets padding = const EdgeInsets.all(10);
  BorderRadius br = const BorderRadius.only(
      topLeft: Radius.circular(24), topRight: Radius.circular(24));

  //이미 바텀 시트 출력 중일 때 새로 바텀 시트를 출력하면 오작동을 막기 위해 구분
  PersistentBottomSheetController? oldSheet;

  void close() {
    state?.close();
    state = null;
  }

  ///서점을 대상으로한 바텀 시트 출력
  void showBookstoreSheet({
    required List<BookStoreMapModel> bookstoreList,
    void Function()? onInnerScrollUp,
    void Function()? onInnerScrollDown,
  }) {
    if (bodyKey.currentContext == null) {
      return;
    }
    BuildContext context = bodyKey.currentState!.context;

    // 이미 켜져 있을 때
    if (state != null) {
      oldSheet = state;
      state = null;
      oldSheet?.closed.then((value) {
        showBookstoreSheet(
            bookstoreList: bookstoreList,
            onInnerScrollDown: onInnerScrollUp,
            onInnerScrollUp: onInnerScrollDown);
      });
      oldSheet?.close();
      oldSheet = null;
      return;
    }

    //버튼 높이 조정
    if (bookstoreList.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(createSnackBar(data: '여기엔 서점이 없어요~'));
      listToggleCon.deactivate();
      return;
    }

    if (bookstoreList.length == 1) {
      buttonHeightCon.toSheet();
    } else if (bookstoreList.length == 2) {
      buttonHeightCon.toTwoSheet();
    } else {
      buttonHeightCon.toSheet();
    }

    listToggleCon.activate();

    //바텀 시트 출력
    state = Scaffold.of(context).showBottomSheet(
        (context) => bookstoreList.length < 3
            ? Container(
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: br),
                padding: padding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    slideIcon,
                    ...bookstoreList
                        .map((e) => BookStoreTile(store: e))
                        .toList()
                  ],
                ))
            : StatefulBuilder(
                builder: (context, setState) {
                  bool isOpend = false;
                  double maxHeight = MediaQuery.of(context).size.height -
                      kBottomNavigationBarHeight -
                      MapBarLong.height;
                  return NotificationListener<DraggableScrollableNotification>(
                    onNotification:
                        (DraggableScrollableNotification dsNotification) {
                      //버튼 높이 조절
                      double updateHeight = (maxHeight) * dsNotification.extent;
                      buttonHeightCon.updateHeight(updateHeight);
                      //바텀 시트가 완전히 펼쳐졌을 때 br, slide icon 조정을 위한 감지
                      if (!isOpend && dsNotification.extent >= 1) {
                        setState(() {
                          isOpend = true;
                        });
                      } else if (isOpend && dsNotification.extent < 1) {
                        setState(() {
                          isOpend = false;
                        });
                      }
                      return false;
                    },
                    child: DraggableScrollableSheet(
                        expand: false,
                        builder: (context, scrollController) {
                          scrollController.addListener(() {
                            if (scrollController.offset > 0.2) {
                              if (scrollController
                                      .position.userScrollDirection ==
                                  ScrollDirection.forward) {
                                if (onInnerScrollUp != null) {
                                  onInnerScrollUp();
                                }
                              } else if (scrollController
                                      .position.userScrollDirection ==
                                  ScrollDirection.reverse) {
                                if (onInnerScrollDown != null) {
                                  onInnerScrollDown();
                                }
                              }
                            }
                          });
                          return SingleChildScrollView(
                            physics:
                                isOpend ? null : NeverScrollableScrollPhysics(),
                            controller: scrollController,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: isOpend ? null : br),
                              width: MediaQuery.of(context).size.width,
                              padding: padding,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isOpend ? SizedBox() : slideIcon,
                                  ...bookstoreList
                                      .map((e) => BookStoreTile(store: e))
                                      .toList()
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                },
              ),
        backgroundColor: Colors.white);
    state?.closed.then((value) {
      onBottomSheetDismissed();
    });
  }

  /// 숨은 서점 출력할 때
  void showHideStore(WidgetRef ref) {
    if (bodyKey.currentContext == null) {
      return;
    }
    BuildContext context = bodyKey.currentState!.context;

    if (state != null) {
      oldSheet = state;
      state = null;
      oldSheet?.closed.then((value) {
        showHideStore(ref);
      });
      oldSheet?.close();
      oldSheet = null;
      return;
    }

    //button height 조절
    buttonHeightCon.toHideBottomSheet();
    //버튼
    listToggleCon.activate();

    state = showBottomSheet(
      context: context,
      builder: (context) {
        return HideBookStoreBottomSheet(
          safeRef: ref,
        );
      },
    );
    state?.closed.then((value) {
      onBottomSheetDismissed();
    });
  }

  ///바텀시트 사라질 때
  void onBottomSheetDismissed() {
    state = null;
    listToggleCon.deactivate();
    hideToggleCon.deactivate();
    buttonHeightCon.toBottom();
    markerCon.setAllNormal();
  }
}

final mapBottomSheetControllerProvider = StateNotifierProvider<
        MapBottomSheetControllerNotifier, PersistentBottomSheetController?>(
    (ref) => MapBottomSheetControllerNotifier(ref));
