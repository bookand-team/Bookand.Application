import 'package:json_annotation/json_annotation.dart';

import '../app_strings.dart';

enum RevokeType {
  /// 콘텐츠 불만족
  @JsonValue('NOT_ENOUGH_CONTENT')
  notEnoughContent(name: AppStrings.reasonContentDissatisfaction),

  /// 이용 방법 불편
  @JsonValue('UNCOMFORTABLE')
  uncomfortable(name: AppStrings.reasonInconvenientToUse),

  /// 개인 정보 유출 우려
  @JsonValue('PRIVACY')
  privacy(name: AppStrings.reasonPrivacyLeak),

  /// 기타
  @JsonValue('ETC')
  etc(name: AppStrings.other);

  final String name;

  const RevokeType({required this.name});
}
