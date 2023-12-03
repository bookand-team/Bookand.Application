import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/model/bookstore/bookstore_map_model.dart';

part 'bookstore_in_map_provider.g.dart';

/// 맵 페이지에서 현재 맵 안에 있는 서점 리스트 가지고 있음 -> 맵 움직이면 리스트 변경을 위해 필요
@Riverpod(keepAlive: true)
class BookstoreInMapProivider extends _$BookstoreInMapProivider {
  BookstoreInMapProivider();

  @override
  List<BookStoreMapModel> build() => [];

  void patchList(List<BookStoreMapModel> list) {
    state = list;
  }
}
