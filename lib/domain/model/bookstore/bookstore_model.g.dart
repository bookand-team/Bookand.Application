// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookstore_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookstoreModel _$BookstoreModelFromJson(Map<String, dynamic> json) =>
    BookstoreModel(
      (json['content'] as List<dynamic>)
          .map((e) => BookstoreContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['last'] as bool,
      json['totalElements'] as int,
      json['totalPages'] as int,
    );

Map<String, dynamic> _$BookstoreModelToJson(BookstoreModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
    };

BookstoreContent _$BookstoreContentFromJson(Map<String, dynamic> json) =>
    BookstoreContent(
      json['id'] as int,
      json['introduction'] as String,
      json['isBookmark'] as bool,
      json['mainImage'] as String,
      json['name'] as String,
      (json['themeList'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BookstoreContentToJson(BookstoreContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'introduction': instance.introduction,
      'isBookmark': instance.isBookmark,
      'mainImage': instance.mainImage,
      'name': instance.name,
      'themeList': instance.themeList,
    };
