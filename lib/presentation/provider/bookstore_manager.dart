import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:bookand/domain/usecase/bookstore_map_usecase.dart';
import 'package:bookand/presentation/provider/bookstore_marker_data_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/map.dart';
import '../../core/util/common_util.dart';
import '../../domain/model/bookstore/bookstore_map_model.dart';

part 'bookstore_manager.g.dart';

/// 앱이 실행중일 때 가지고 있어야할 서점 데이터와 맵에 표시해줄 마커 데이터
/// 북마크 여부 여기서 갱신 및 다른 페이지에서도 호출
@Riverpod(keepAlive: true)
class BookStoreManager extends _$BookStoreManager {
  BookStoreManager();

  @override
  List<BookStoreMapModel> build() => [];

  bool isInited = false;
  bool bLog = false;

  // 모든 서점 데이터 초기화
  Future init() async {
    if (isInited) {
      return;
    }
    isInited = true;
    try {
      final response =
          await ref.read(bookstoreMapUsecaseProvider).getBookstores();
      state = response.bookStoreAddressListResponse ?? [];
      if (bLog) log('BookStoreManager, init, data = $state');
      if (state.isNotEmpty) {
        // 마커 데이터 초기화
        ref.read(bookStoreMarkerDataManagerProvider.notifier).init(state);
      }
    } catch (e) {
      isInited = false;
      log('BookStoreManager, init, e = $e');
    }
  }

  // TODO 북마크 상태 변경 -> 다른 곳에서 쓰는 거랑 통일을 해야함
  void updateBookmark(int id, bool value) {
    int index = state.indexWhere((element) => element.id == id);
    if (index != -1) {
      state[index].isBookmark = value;
      state = [...state];
      if (bLog)
        log('BookStoreManager, updateBookmark, value = $value, output = ${state[index].isBookmark}');
    }
  }

  BookStoreMapModel? getRandomStore() {
    if (state.isNotEmpty) {
      final randomIndex = math.Random().nextInt(state.length);
      //filter bookstore 중 하나 선택
      final randomModel = state[randomIndex];
      return randomModel;
    } else {
      return null;
    }
  }

  void patchStoresDistanceBetweenUser(LatLng coord) {
    //데이터에 유저간의 거리 추가
    for (BookStoreMapModel store in state) {
      store.userDistance = CommonUtil.getDistance(
          lat1: coord.latitude,
          lon1: coord.longitude,
          lat2: store.latitude ?? SEOUL_COORD_LAT,
          lon2: store.longitude ?? SEOUL_COORD_LON);
    }
    //거리 순 정렬
    state.sort(
      (a, b) => a.userDistance!.compareTo(b.userDistance!),
    );
    state = [...state];
  }
}
