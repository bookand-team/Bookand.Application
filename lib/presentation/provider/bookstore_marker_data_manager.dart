import 'dart:async';
import 'dart:developer';

import 'package:bookand/core/const/enum_boomark_marker_type.dart';
import 'package:bookand/core/util/marker_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/model/bookstore/bookstore_map_model.dart';

part 'bookstore_marker_data_manager.g.dart';

/// 앱이 실행중일 때 맵에 표시해줄 마커의 icon 데이터 버퍼를 지니고 있음
/// id : {markerType : markerData}
/// markerType -> 기본, 기본(큰), 북마크, 북마크(큰), 숨은서점
@Riverpod(keepAlive: true)
class BookStoreMarkerDataManager extends _$BookStoreMarkerDataManager {
  BookStoreMarkerDataManager();
  @override
  Map<int, Map<BookStoreMarkerType, BitmapDescriptor>> build() => {};

  bool isInited = false;
  bool isIniting = false;
  bool bLog = false;

  // 갤럭시 A51G 기준 실행시간 621 ms(비동기화), 23632ms(동기화)
  Future init(List<BookStoreMapModel> bookstores) async {
    DateTime dateTime = DateTime.now();
    int len = bookstores.length * 5;
    int count = 0;
    if (isInited || isIniting) {
      return;
    }
    isIniting = true;
    for (var bookstore in bookstores) {
      if (bookstore.id == null || bookstore.name == null) {
        continue;
      }
      for (var type in BookStoreMarkerType.values) {
        MarkerUtils.createIconData(bookstore.name!, type).then((marker) {
          // 버퍼에 추가
          if (state[bookstore.id!] == null) {
            state[bookstore.id!] = {};
          }
          state[bookstore.id!]?.addAll({type: marker});
          count += 1;
          if (bLog)
            log('BookStoreMarkerDataManager, init, ${bookstore.name} -> $type added');
          if (len == count) {
            isInited = true;
            isIniting = false;
            if (bLog)
              log('BookStoreMarkerDataManager, init complete, time = ${DateTime.now().difference(dateTime).inMilliseconds}');
            state = Map.from(state);
          }
        }).catchError((e) {
          isIniting = false;
          isInited = false;
          log('BookStoreMarkerDataManager, init, e = $e');
        });
      }
    }
  }

  BitmapDescriptor? getMarkerData(int id, BookStoreMarkerType type) {
    return state[id]?[type];
  }
}
