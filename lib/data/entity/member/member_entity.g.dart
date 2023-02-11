// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberEntity _$MemberEntityFromJson(Map<String, dynamic> json) => MemberEntity(
      json['id'] as int,
      json['email'] as String,
      json['nickname'] as String,
      json['providerEmail'] as String,
    );

Map<String, dynamic> _$MemberEntityToJson(MemberEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'providerEmail': instance.providerEmail,
    };
