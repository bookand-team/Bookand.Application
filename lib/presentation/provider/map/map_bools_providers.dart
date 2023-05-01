import 'package:bookand/presentation/screen/main/map/component/top_bar/components/hide_book_store_bottom_sheet.dart';
import 'package:bookand/presentation/screen_logic/map/toggle_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'map_button_height_provider.dart';
import 'map_panel_visible_provider.dart';

//북마크 버튼에 따라 토글되는 state
class BookMarkToggleNotifier extends StateNotifier<bool>
    implements ToggleLogic {
  BookMarkToggleNotifier() : super(false);

  @override
  void toggle() {
    state = !state;
  }

  @override
  void activate() {
    state = true;
  }

  @override
  void deactivate() {
    state = false;
  }
}

final bookMarkToggleProvider =
    StateNotifierProvider<BookMarkToggleNotifier, bool>(
        (ref) => BookMarkToggleNotifier());

//gps 버튼에 따라 토글되는 state
class GpsToggleNotifier extends StateNotifier<bool> implements ToggleLogic {
  GpsToggleNotifier() : super(false);

  @override
  void toggle() {
    state = !state;
  }

  @override
  void activate() {
    state = true;
  }

  @override
  void deactivate() {
    state = false;
  }
}

final gpsToggleProvider = StateNotifierProvider<GpsToggleNotifier, bool>(
    (ref) => GpsToggleNotifier());

///map bottom sheet gesture에 따라 변경되는 search bar visible state
class SearchBarToggleNotifier extends StateNotifier<bool>
    implements ToggleLogic {
  SearchBarToggleNotifier() : super(true);

  @override
  void toggle() {
    state = !state;
  }

  @override
  void activate() {
    state = true;
  }

  @override
  void deactivate() {
    state = false;
  }
}

final searchBarToggleProvider =
    StateNotifierProvider<SearchBarToggleNotifier, bool>(
        (ref) => SearchBarToggleNotifier());

///숨은 서점 버튼에 따라 토글되는 hide store visible state
class HideStoreToggleNotifier extends StateNotifier<bool> {
  HideStoreToggleNotifier() : super(false);
  PersistentBottomSheetController? bottomSheetController;

  void toggle() {
    state = !state;
  }

  //hidestore bottomsheet 출력
  void activate({required WidgetRef ref, required BuildContext context}) {
    state = true;
    ref.read(mapPanelVisibleNotifierProvider.notifier).deactivate();
    ref.read(mapButtonHeightNotifierProvider.notifier).toHideBottomSheet();

    showHideStore(ref, context);
  }

  void deactivate() {
    state = false;
    bottomSheetController?.close();
  }

  void showHideStore(WidgetRef ref, BuildContext context) {
    bottomSheetController = showBottomSheet(
      context: context,
      builder: (context) {
        return HideBookStoreBottomSheet(
          safeRef: ref,
        );
      },
    );
  }
}

final hideStoreToggleProvider =
    StateNotifierProvider<HideStoreToggleNotifier, bool>(
        (ref) => HideStoreToggleNotifier());

///theme 버튼 열고 있을 때 활성화 용
class ThemeToggleNotifier extends StateNotifier<bool> implements ToggleLogic {
  ThemeToggleNotifier() : super(false);

  @override
  void toggle() {
    state = !state;
  }

  @override
  void activate() {
    state = true;
  }

  @override
  void deactivate() {
    state = false;
  }
}

final themeToggleProvider = StateNotifierProvider<ThemeToggleNotifier, bool>(
    (ref) => ThemeToggleNotifier());

//search page에서 검색을 한 건지 안한 건지
class MapSearchPageSearchedNotifier extends StateNotifier<bool>
    implements ToggleLogic {
  MapSearchPageSearchedNotifier() : super(false);
  @override
  void toggle() {
    state = !state;
  }

  @override
  void activate() {
    state = true;
  }

  @override
  void deactivate() {
    state = false;
  }
}

final mapSearchPageSearchedProvider =
    StateNotifierProvider<MapSearchPageSearchedNotifier, bool>(
        (ref) => MapSearchPageSearchedNotifier());
