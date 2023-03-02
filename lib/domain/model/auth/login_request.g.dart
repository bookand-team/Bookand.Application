// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      json['accessToken'] as String,
      $enumDecode(_$SocialTypeEnumMap, json['socialType']),
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'socialType': _$SocialTypeEnumMap[instance.socialType]!,
    };

const _$SocialTypeEnumMap = {
  SocialType.NONE: 'NONE',
  SocialType.GOOGLE: 'GOOGLE',
  SocialType.APPLE: 'APPLE',
};
