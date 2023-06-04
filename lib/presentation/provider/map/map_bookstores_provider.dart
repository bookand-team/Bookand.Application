import 'dart:math';

import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/util/common_util.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/domain/usecase/bookstore_map_usecase.dart';
import 'package:bookand/presentation/provider/map/bools/map_bookmark_toggle.dart';
import 'package:bookand/presentation/provider/map/map_theme_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_bookstores_provider.g.dart';

///map에 출력할 boostoremodel 관리, 테마, 북마크 버튼 토글 시 마다 filter됨
@Riverpod(keepAlive: true)
class MapBookStoreNotifier extends _$MapBookStoreNotifier with ChangeNotifier {
  late BookMarkToggleNotifier bookmarkToggle;
  late MapThemeNotifier mapTheme;

  @override
  List<BookStoreMapModel> build() {
    bookmarkToggle = ref.read(bookMarkToggleNotifierProvider.notifier);
    mapTheme = ref.read(mapThemeNotifierProvider.notifier);
    return <BookStoreMapModel>[];
  }

  //원본 다 가지고 있을 리스트
  List<BookStoreMapModel> storedList = [];

  ///server에서 데이터 받은 후, 사용자 위치간의 거리를 계산하여 가까운 순으로 정렬
  Future<List<BookStoreMapModel>> initBookStores() async {
    //데이터 받음
    final response =
        await ref.read(bookstoreMapUsecaseProvider).getBookstores();

    if (response.bookStoreAddressListResponse != null) {
      state.addAll(response.bookStoreAddressListResponse!);
    }
    state = [...state];

    return state;
  }

  void patchStoresDistanceBetweenUser(
      {required double userLat, required double userLon}) {
    //데이터에 유저간의 거리 추가
    for (BookStoreMapModel store in state) {
      store.userDistance = CommonUtil.getDistance(
          lat1: userLat,
          lon1: userLon,
          lat2: store.latitude ?? SEOUL_COORD_LAT,
          lon2: store.longitude ?? SEOUL_COORD_LON);
    }
    //거리 순 정렬
    state.sort(
      (a, b) => a.userDistance!.compareTo(b.userDistance!),
    );

    state = [...state];
  }

  void filteredBookstores() {
    bool isBookmark = bookmarkToggle.getState();
    List<Themes> selectedThemes = mapTheme.getState();

    List<BookStoreMapModel> filteredList = List.from(storedList);

    if (isBookmark) {
      filteredList.removeWhere((element) => element.isBookmark == false);
    }
    if (selectedThemes.isNotEmpty) {
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
