import 'package:bookand/core/app_strings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum FeedbackType {
  @JsonValue('PUSH')
  push(name: '알림이 너무 자주 와요'),
  @JsonValue('INFORMATION_ERROR')
  information(name: '정보가 정확하지 않거나 부족해요'),
  @JsonValue('INCONVENIENCE')
  use(name: '이용방법이 불편해요'),
  @JsonValue('ETC')
  etc(name: AppStrings.other);

  final String name;

  const FeedbackType({required this.name});
}
