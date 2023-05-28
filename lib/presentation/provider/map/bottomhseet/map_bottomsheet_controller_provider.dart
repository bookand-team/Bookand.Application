//북마크 버튼에 따라 토글되는 state
import 'dart:developer';

import 'package:bookand/core/widget/slide_icon.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/component/bookstore_snackbar.dart';
import 'package:bookand/presentation/provider/map/bools/map_hidestore_toggle.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_button_min_height_provider.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_list_toggle.dart';
import 'package:bookand/presentation/screen/main/map/component/book_store_tile.dart';
import 'package:bookand/presentation/screen/main/map/component/top_bar/components/hide_book_store_bottom_sheet.dart';
import 'package:bookand/presentation/screen/main/map/component/top_bar/map_bar_long.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapBottomSheetControllerNotifier
    extends StateNotifier<PersistentBottomSheetController?> {
  late MapButtonHeightNotifier buttonHeightProvider;
  late MapButtonMinHeightProvider buttonMinHeightProvider;
  late MapListToggle listToggle;
  MapBottomSheetControllerNotifier(StateNotifierProviderRef ref) : super(null) {
    buttonHeightProvider = ref.read(mapButtonHeightNotifierProvider.notifier);
    buttonMinHeightProvider = ref.read(mapButtonMinHeightNotifier.notifier);
    listToggle = ref.read(mapListToggleProvider.notifier);
  }
  EdgeInsets padding = const EdgeInsets.all(10);
  BorderRadius br = const BorderRadius.only(
      topLeft: Radius.circular(24), topRight: Radius.circular(24));

  void close() {
    state?.close();
  }

  ///서점 3개 이상을 출력하여 화면을 꽉 채울 때 용도
  void showBookstoreSheet({
    required BuildContext context,
    required List<BookStoreMapModel> bookstoreList,
    void Function()? onInnerScrollUp,
    void Function()? onInnerScrollDown,
  }) {
    // 이미 켜져있는 거 끄기
    state?.close();
    //버튼 높이 조정

    if (bookstoreList.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(createSnackBar(data: '여기엔 서점이 없어요~'));
      listToggle.deactivate();
      return;
    }

    if (bookstoreList.length == 1) {
      buttonMinHeightProvider.toSheet();
    } else if (bookstoreList.length == 2) {
      buttonMinHeightProvider.toTwoSheet();
    } else {
      buttonMinHeightProvider.toSheet();
    }

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
                      log('max = $maxHeight extent= ${dsNotification.extent.toString()}');
                      //버튼 높이 조절
                      double updateHeight = (maxHeight) * dsNotification.extent;
                      buttonMinHeightProvider.setMinHeight(updateHeight);
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
                      return true;
                    },
                    child: DraggableScrollableSheet(
                        expand: false,
                        builder: (context, scrollController) {
                          scrollController.addListener(() {
                            log(scrollController.offset.toString());
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
    close();

    //button height 조절
    buttonMinHeightProvider.toHideBottomSheet();
    //버튼
    listToggle.activate();

    state = showBottomSheet(
      context: ref.context,
      builder: (context) {
        return HideBookStoreBottomSheet(
          safeRef: ref,
        );
      },
    );
    state?.closed.then((value) {
      onBottomSheetDismissed();
      ref.read(hideStoreToggleProvider.notifier).deactivate();
    });
  }

  ///바텀시트 사라질 때
  void onBottomSheetDismissed() {
    listToggle.deactivate();
    buttonMinHeightProvider.toBottom();
    buttonHeightProvider.toBottomAnimation();
  }
}

final mapBottomSheetControllerProvider = StateNotifierProvider<
        MapBottomSheetControllerNotifier, PersistentBottomSheetController?>(
    (ref) => MapBottomSheetControllerNotifier(ref));
