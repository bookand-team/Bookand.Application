// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDetailModel _$NotificationDetailModelFromJson(
        Map<String, dynamic> json) =>
    NotificationDetailModel(
      json['id'] as int,
      json['title'] as String,
      json['content'] as String,
      json['createdAt'] as String,
    );

Map<String, dynamic> _$NotificationDetailModelToJson(
        NotificationDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt,
    };
