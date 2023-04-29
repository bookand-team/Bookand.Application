import 'package:bookand/core/util/logger.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/provider/map/map_theme_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_filtered_book_store_provider.g.dart';

//map에 출력할 boostoremodel 관리 프로바이더
@Riverpod(keepAlive: true)
class MapFilteredBooksStoreNotifier extends _$MapFilteredBooksStoreNotifier
    with ChangeNotifier {
  @override
  List<BookStoreMapModel> build() => <BookStoreMapModel>[];

  ///server에서 데이터 받은 후, 사용자 위치간의 거리를 계산하여 가까운 순으로 정렬
  void filteredBookstroes({bool? isBookmark, List<Themes>? selectedThemes}) {
    isBookmark ??= ref.read(bookMarkToggleProvider);
    selectedThemes ??= ref.read(mapThemeNotifierProvider);

    List<BookStoreMapModel> filteredList =
        List.from(ref.read(mapBooksStoreNotifierProvider));
    if (isBookmark!) {
      filteredList.removeWhere((element) => element.isBookmark == false);
    }
    if (selectedThemes!.isNotEmpty) {
      //store의 테마가 없으면 제거 (좀 더 비교 대상 줄이기)
      filteredList.removeWhere((bookstore) => bookstore.theme?.isEmpty ?? true);
      //체크한 테마 개수랑 store  테마 개수 안맞으면 제거(좀 더 비교 대상 줄이기)
      filteredList.removeWhere((bookstore) {
        logger.d('${bookstore.theme!.length} ${selectedThemes!.length}');
        return bookstore.theme!.length != selectedThemes!.length;
      });
      //다르면 제거
      filteredList.removeWhere((bookstore) {
        List<int> selected = selectedThemes!.map((e) => e.index).toList();
        List<int> storeThemes = bookstore.theme!.map((e) => e.index).toList();
        return !listEquals(selected, storeThemes);
      });
    }
    state = filteredList;
  }

  //마커 출력
  void showMarker() {
    ref.read(widgetMarkerNotiferProvider.notifier).setBookstoreMarker(state);
  }

  void filterAndShowMarker({bool? isBookmark, List<Themes>? selectedThemes}) {
    filteredBookstroes(isBookmark: isBookmark, selectedThemes: selectedThemes);
    showMarker();
  }
}
