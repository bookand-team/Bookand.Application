// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialToken _$SocialTokenFromJson(Map<String, dynamic> json) => SocialToken(
      json['accessToken'] as String,
      $enumDecode(_$SocialTypeEnumMap, json['socialType']),
    );

Map<String, dynamic> _$SocialTokenToJson(SocialToken instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'socialType': _$SocialTypeEnumMap[instance.socialType]!,
    };

const _$SocialTypeEnumMap = {
  SocialType.google: 'google',
  SocialType.apple: 'apple',
};
