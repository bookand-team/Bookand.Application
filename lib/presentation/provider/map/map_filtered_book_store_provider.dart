import 'dart:math';

import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/bools/map_bookmark_toggle.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/map_theme_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_filtered_book_store_provider.g.dart';

//map에 출력할 boostoremodel 관리 프로바이더
@Riverpod(keepAlive: true)
class MapFilteredBookStoreNotifier extends _$MapFilteredBookStoreNotifier
    with ChangeNotifier {
  @override
  List<BookStoreMapModel> build() => <BookStoreMapModel>[];

  ///이미 받은 bookstore데이터에서 bookmark, theme 필터링
  void filteredBookstroes({bool? isBookmark, List<Themes>? selectedThemes}) {
    isBookmark ??= ref.read(bookMarkToggleProvider);
    selectedThemes ??= ref.read(mapThemeNotifierProvider);

    List<BookStoreMapModel> filteredList =
        List.from(ref.read(mapBookStoreNotifierProvider));
    if (isBookmark!) {
      filteredList.removeWhere((element) => element.isBookmark == false);
    }
    if (selectedThemes!.isNotEmpty) {
      //store의 테마가 없으면 제거 (좀 더 비교 대상 줄이기)
      filteredList.removeWhere((bookstore) => bookstore.theme?.isEmpty ?? true);

      //선택한 테마를 가지고 있지 않으면 제거
      for (Themes selectedTheme in selectedThemes) {
        filteredList.removeWhere((bookstore) {
          Set<int> storeThemes = bookstore.theme!.map((e) => e.index).toSet();
          return !storeThemes.contains(selectedTheme.index);
        });
      }
    }
    state = filteredList;
  }

  void filterAndShowMarker({bool? isBookmark, List<Themes>? selectedThemes}) {
    filteredBookstroes(isBookmark: isBookmark, selectedThemes: selectedThemes);
    ref.read(widgetMarkerNotiferProvider.notifier).setBookstoreMarker(state);
  }

  BookStoreMapModel? getRandomStore() {
    if (state.isNotEmpty) {
      final randomIndex = Random().nextInt(state.length);
      //filter bookstore 중 하나 선택
      final randomModel = state[randomIndex];
      return randomModel;
    } else {
      return null;
    }
  }
}
