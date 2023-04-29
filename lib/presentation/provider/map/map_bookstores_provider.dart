import 'package:bookand/core/util/common_util.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/domain/usecase/bookstore_map_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_bookstores_provider.g.dart';

//map에 출력할 boostoremodel 관리 프로바이더
@Riverpod(keepAlive: true)
class MapBooksStoreNotifier extends _$MapBooksStoreNotifier
    with ChangeNotifier {
  @override
  List<BookStoreMapModel> build() => <BookStoreMapModel>[];

  ///server에서 데이터 받은 후, 사용자 위치간의 거리를 계산하여 가까운 순으로 정렬
  Future<List<BookStoreMapModel>?> fetchBookstoreList(
      {required double userLat, required double userLon}) async {
    state = [];
    List<BookStoreMapModel> formattedList = [];
    //데이터 받음
    final response =
        await ref.read(bookstoreMapUsecaseProvider).getBookstores();
    //데이터에 유저간의 거리 추가
    response.bookStoreAddressListResponse?.forEach((element) {
      element.userDistance = CommonUtil.getDistance(
          lat1: userLat,
          lon1: userLon,
          lat2: element.latitude!,
          lon2: element.longitude!);
      state.add(element);
    });
    //정렬
    formattedList.sort(
      (a, b) => a.userDistance!.compareTo(b.userDistance!),
    );
    //state
    state.addAll(formattedList);
    return formattedList;
  }
}
