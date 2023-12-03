import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/util/common_util.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {
  /// 현재 화면에 있는 것만 출력
  static Future<List<BookStoreMapModel>> getBookstoresInScreen(
      List<BookStoreMapModel> bookstoreList, LatLngBounds bounds) async {
    List<BookStoreMapModel> list = [];
    for (BookStoreMapModel bookstore in bookstoreList) {
      if (CommonUtil.coordInRect(
          targetLat: bookstore.latitude ?? SEOUL_COORD_LAT,
          targetLon: bookstore.longitude ?? SEOUL_COORD_LON,
          minLat: bounds.southwest.latitude,
          minLon: bounds.southwest.longitude,
          maxLat: bounds.northeast.latitude,
          maxLon: bounds.northeast.longitude)) {
        list.add(bookstore);
      }
    }
    return list;
  }
}
