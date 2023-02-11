import 'package:json_annotation/json_annotation.dart';

import '../../../core/const/social_type.dart';

part 'social_token.g.dart';

@JsonSerializable()
class SocialToken {
  final String accessToken;
  final SocialType socialType;

  SocialToken(this.accessToken, this.socialType);

  factory SocialToken.fromJson(Map<String, dynamic> json) =>
      _$SocialTokenFromJson(json);

  Map<String, dynamic> toJson() => _$SocialTokenToJson(this);
}
