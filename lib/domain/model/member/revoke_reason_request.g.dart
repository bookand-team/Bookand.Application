// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_reason_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevokeReasonRequest _$RevokeReasonRequestFromJson(Map<String, dynamic> json) =>
    RevokeReasonRequest(
      json['reason'] as String?,
      $enumDecode(_$RevokeTypeEnumMap, json['revokeType']),
      json['socialAccessToken'] as String,
    );

Map<String, dynamic> _$RevokeReasonRequestToJson(
        RevokeReasonRequest instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'revokeType': _$RevokeTypeEnumMap[instance.revokeType]!,
      'socialAccessToken': instance.socialAccessToken,
    };

const _$RevokeTypeEnumMap = {
  RevokeType.notEnoughContent: 'NOT_ENOUGH_CONTENT',
  RevokeType.uncomfortable: 'UNCOMFORTABLE',
  RevokeType.privacy: 'PRIVACY',
  RevokeType.etc: 'ETC',
};
