import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/util/common_util.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_filtered_book_store_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_in_screen_bookstores_provider.g.dart';

//map에 출력할 boostoremodel 관리 프로바이더
@Riverpod(keepAlive: true)
class MapInScreenBookStoreNotifier extends _$MapInScreenBookStoreNotifier
    with ChangeNotifier {
  @override
  List<BookStoreMapModel> build() => <BookStoreMapModel>[];

  /// 현재 화면에 있는 것만 출력
  Future<List<BookStoreMapModel>> fetchInScreenBookstore() async {
    List<BookStoreMapModel> list = [];
    LatLngBounds? bounds = await ref
        .read(mapControllerNotiferProvider.notifier)
        .getScreenLatLngBounds();
    ref.read(mapFilteredBookStoreNotifierProvider).forEach((bookstore) {
      if (CommonUtil.coordInRect(
          targetLat: bookstore.latitude ?? SEOUL_COORD_LAT,
          targetLon: bookstore.longitude ?? SEOUL_COORD_LON,
          minLat: bounds!.southwest.latitude,
          minLon: bounds.southwest.longitude,
          maxLat: bounds.northeast.latitude,
          maxLon: bounds.northeast.longitude)) {
        list.add(bookstore);
      }
    });
    state = list;
    return list;
  }

  void setOne(BookStoreMapModel model) {
    state = [model];
  }
}
