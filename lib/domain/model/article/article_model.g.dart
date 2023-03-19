// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      (json['content'] as List<dynamic>)
          .map((e) => ArticleContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['last'] as bool,
      json['totalElements'] as int,
      json['totalPages'] as int,
    );

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
    };

ArticleContent _$ArticleContentFromJson(Map<String, dynamic> json) =>
    ArticleContent(
      (json['articleTagList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['category'] as String,
      json['content'] as String,
      json['createdData'] as String,
      json['id'] as int,
      json['isBookmark'] as bool,
      json['mainImage'] as String,
      json['modifiedDate'] as String,
      json['status'] as String,
      json['title'] as String,
      json['view'] as int,
      json['visibility'] as bool,
      json['writer'] as String,
    );

Map<String, dynamic> _$ArticleContentToJson(ArticleContent instance) =>
    <String, dynamic>{
      'articleTagList': instance.articleTagList,
      'category': instance.category,
      'content': instance.content,
      'createdData': instance.createdData,
      'id': instance.id,
      'isBookmark': instance.isBookmark,
      'mainImage': instance.mainImage,
      'modifiedDate': instance.modifiedDate,
      'status': instance.status,
      'title': instance.title,
      'view': instance.view,
      'visibility': instance.visibility,
      'writer': instance.writer,
    };
