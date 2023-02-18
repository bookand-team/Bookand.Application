// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicyModel _$PolicyModelFromJson(Map<String, dynamic> json) => PolicyModel(
      json['policyId'] as int,
      json['title'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$PolicyModelToJson(PolicyModel instance) =>
    <String, dynamic>{
      'policyId': instance.policyId,
      'title': instance.title,
      'content': instance.content,
    };
