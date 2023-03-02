// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PolicyModel _$PolicyModelFromJson(Map<String, dynamic> json) => PolicyModel(
      policyId: json['policyId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
    );

Map<String, dynamic> _$PolicyModelToJson(PolicyModel instance) =>
    <String, dynamic>{
      'policyId': instance.policyId,
      'title': instance.title,
      'content': instance.content,
    };
