import 'dart:math' as math;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/model/bookstore/bookstore_map_model.dart';

part 'bookstore_hide_recommendation_provider.g.dart';

/// 맵 페이지에서 숨은 서점을 리스트 안에서 갱신하기 위해 사용
@Riverpod(keepAlive: true)
class BookstoreHideRecommendationProivider
    extends _$BookstoreHideRecommendationProivider {
  BookstoreHideRecommendationProivider();

  @override
  BookStoreMapModel? build() => null;

  BookStoreMapModel? refreshRandomStore(List<BookStoreMapModel> list) {
    if (list.isNotEmpty) {
      final randomIndex = math.Random().nextInt(list.length);
      //filter bookstore 중 하나 선택
      final randomModel = list[randomIndex];
      state = randomModel;
      return state;
    } else {
      return null;
    }
  }
}
