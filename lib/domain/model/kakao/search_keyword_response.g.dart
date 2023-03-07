// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_keyword_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchKeywordResponse _$SearchKeywordResponseFromJson(
        Map<String, dynamic> json) =>
    SearchKeywordResponse(
      SearchKeywordMeta.fromJson(json['meta'] as Map<String, dynamic>),
      (json['documents'] as List<dynamic>)
          .map((e) => SearchKeywordDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchKeywordResponseToJson(
        SearchKeywordResponse instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'documents': instance.documents,
    };

SearchKeywordMeta _$SearchKeywordMetaFromJson(Map<String, dynamic> json) =>
    SearchKeywordMeta(
      json['total_count'] as int,
      json['pageable_count'] as int,
      json['is_end'] as bool,
      SearchKeywordSameName.fromJson(json['same_name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchKeywordMetaToJson(SearchKeywordMeta instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'pageable_count': instance.pageableCount,
      'is_end': instance.isEnd,
      'same_name': instance.sameName,
    };

SearchKeywordSameName _$SearchKeywordSameNameFromJson(
        Map<String, dynamic> json) =>
    SearchKeywordSameName(
      (json['region'] as List<dynamic>).map((e) => e as String).toList(),
      json['keyword'] as String,
      json['selected_region'] as String,
    );

Map<String, dynamic> _$SearchKeywordSameNameToJson(
        SearchKeywordSameName instance) =>
    <String, dynamic>{
      'region': instance.region,
      'keyword': instance.keyword,
      'selected_region': instance.selectedRegion,
    };

SearchKeywordDocument _$SearchKeywordDocumentFromJson(
        Map<String, dynamic> json) =>
    SearchKeywordDocument(
      json['id'] as String,
      json['place_name'] as String,
      json['category_name'] as String,
      json['category_group_code'] as String,
      json['category_group_name'] as String,
      json['phone'] as String,
      json['address_name'] as String,
      json['road_address_name'] as String,
      json['x'] as String,
      json['y'] as String,
      json['place_url'] as String,
      json['distance'] as String,
    );

Map<String, dynamic> _$SearchKeywordDocumentToJson(
        SearchKeywordDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'place_name': instance.placeName,
      'category_name': instance.categoryName,
      'category_group_code': instance.categoryGroupCode,
      'category_group_name': instance.categoryGroupName,
      'phone': instance.phone,
      'address_name': instance.addressName,
      'road_address_name': instance.roadAddressName,
      'x': instance.x,
      'y': instance.y,
      'place_url': instance.placeUrl,
      'distance': instance.distance,
    };
