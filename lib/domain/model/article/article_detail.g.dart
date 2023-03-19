// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDetail _$ArticleDetailFromJson(Map<String, dynamic> json) =>
    ArticleDetail(
      (json['articleTagList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['bookstoreList'] as List<dynamic>)
          .map((e) => BookstoreContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['bookmark'] as bool,
      json['bookmarkCount'] as int,
      json['category'] as String,
      json['content'] as String,
      json['createdDate'] as String,
      json['displayData'] as String,
      ArticleFilter.fromJson(json['filter'] as Map<String, dynamic>),
      json['id'] as int,
      json['mainImage'] as String,
      json['modifiedDate'] as String,
      json['status'] as String,
      json['title'] as String,
      json['view'] as int,
      json['visibility'] as bool,
      json['writer'] as String,
    );

Map<String, dynamic> _$ArticleDetailToJson(ArticleDetail instance) =>
    <String, dynamic>{
      'articleTagList': instance.articleTagList,
      'bookstoreList': instance.bookstoreList,
      'bookmark': instance.bookmark,
      'bookmarkCount': instance.bookmarkCount,
      'category': instance.category,
      'content': instance.content,
      'createdDate': instance.createdDate,
      'displayData': instance.displayData,
      'filter': instance.filter,
      'id': instance.id,
      'mainImage': instance.mainImage,
      'modifiedDate': instance.modifiedDate,
      'status': instance.status,
      'title': instance.title,
      'view': instance.view,
      'visibility': instance.visibility,
      'writer': instance.writer,
    };

ArticleFilter _$ArticleFilterFromJson(Map<String, dynamic> json) =>
    ArticleFilter(
      json['deviceOS'] as String,
      json['memberId'] as String,
    );

Map<String, dynamic> _$ArticleFilterToJson(ArticleFilter instance) =>
    <String, dynamic>{
      'deviceOS': instance.deviceOS,
      'memberId': instance.memberId,
    };
