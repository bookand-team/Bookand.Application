import 'package:freezed_annotation/freezed_annotation.dart';

import '../app_strings.dart';

enum FeedbackTarget {
  @JsonValue('HOME')
  home(name: AppStrings.home),
  @JsonValue('MAP')
  map(name: AppStrings.map),
  @JsonValue('BOOKMARK')
  bookmark(name: AppStrings.bookmark),
  @JsonValue('MY_PAGE')
  myPage(name: AppStrings.myPage),
  @JsonValue('ETC')
  etc(name: AppStrings.other),
  @JsonValue('ARTICLE')
  article(name: '아티클'),
  @JsonValue('BOOKSTORE')
  bookstore(name: '서점 정보');

  final String name;

  const FeedbackTarget({required this.name});
}
