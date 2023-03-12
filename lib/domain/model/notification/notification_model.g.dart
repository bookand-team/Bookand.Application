// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      (json['content'] as List<dynamic>)
          .map((e) => NotificationContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['last'] as bool,
      json['totalElements'] as int,
      json['totalPages'] as int,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
    };

NotificationContent _$NotificationContentFromJson(Map<String, dynamic> json) =>
    NotificationContent(
      json['id'] as int,
      json['title'] as String,
      json['content'] as String,
      json['createdAt'] as String,
    );

Map<String, dynamic> _$NotificationContentToJson(
        NotificationContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt,
    };
