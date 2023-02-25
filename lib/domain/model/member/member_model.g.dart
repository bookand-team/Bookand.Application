// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel(
      id: json['id'] as int,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      providerEmail: json['providerEmail'] as String,
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'providerEmail': instance.providerEmail,
      'profileImage': instance.profileImage,
    };
