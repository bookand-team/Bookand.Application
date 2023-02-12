// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicyEntity _$PolicyEntityFromJson(Map<String, dynamic> json) => PolicyEntity(
      json['policyId'] as int,
      json['title'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$PolicyEntityToJson(PolicyEntity instance) =>
    <String, dynamic>{
      'policyId': instance.policyId,
      'title': instance.title,
      'content': instance.content,
    };
