// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_keyword_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchKeywordRequest _$SearchKeywordRequestFromJson(
        Map<String, dynamic> json) =>
    SearchKeywordRequest(
      json['query'] as String,
      categoryGroupCode: json['category_group_code'] as String?,
      x: json['x'] as String?,
      y: json['y'] as String?,
      radius: json['radius'] as int?,
      rect: json['rect'] as String?,
      page: json['page'] as int?,
      size: json['size'] as int?,
      sort: json['sort'] as String?,
    );

Map<String, dynamic> _$SearchKeywordRequestToJson(
        SearchKeywordRequest instance) =>
    <String, dynamic>{
      'query': instance.query,
      'category_group_code': instance.categoryGroupCode,
      'x': instance.x,
      'y': instance.y,
      'radius': instance.radius,
      'rect': instance.rect,
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
    };
