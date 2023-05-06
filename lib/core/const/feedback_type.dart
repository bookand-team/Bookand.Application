import 'package:bookand/core/app_strings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum FeedbackType {
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
  @JsonValue('')
  article(name: '아티클'),
  @JsonValue('')
  bookstore(name: '서점 정보');

  final String name;

  const FeedbackType({required this.name});
}
