import 'package:json_annotation/json_annotation.dart';

part 'search_keyword_response.g.dart';

@JsonSerializable()
class SearchKeywordResponse {
  final SearchKeywordMeta meta;
  final List<SearchKeywordDocument> documents;

  SearchKeywordResponse(this.meta, this.documents);

  factory SearchKeywordResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeywordResponseToJson(this);
}

@JsonSerializable()
class SearchKeywordMeta {
  @JsonKey(name: 'total_count')
  final int totalCount;
  @JsonKey(name: 'pageable_count')
  final int pageableCount;
  @JsonKey(name: 'is_end')
  final bool isEnd;
  @JsonKey(name: 'same_name')
  final SearchKeywordSameName sameName;

  SearchKeywordMeta(
    this.totalCount,
    this.pageableCount,
    this.isEnd,
    this.sameName,
  );

  factory SearchKeywordMeta.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordMetaFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeywordMetaToJson(this);
}

@JsonSerializable()
class SearchKeywordSameName {
  final List<String> region;
  final String keyword;
  @JsonKey(name: 'selected_region')
  final String selectedRegion;

  SearchKeywordSameName(this.region, this.keyword, this.selectedRegion);

  factory SearchKeywordSameName.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordSameNameFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeywordSameNameToJson(this);
}

@JsonSerializable()
class SearchKeywordDocument {
  final String id;
  @JsonKey(name: 'place_name')
  final String placeName;
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey(name: 'category_group_code')
  final String categoryGroupCode;
  @JsonKey(name: 'category_group_name')
  final String categoryGroupName;
  final String phone;
  @JsonKey(name: 'address_name')
  final String addressName;
  @JsonKey(name: 'road_address_name')
  final String roadAddressName;
  final String x;
  final String y;
  @JsonKey(name: 'place_url')
  final String placeUrl;
  final String distance;

  SearchKeywordDocument(
      this.id,
      this.placeName,
      this.categoryName,
      this.categoryGroupCode,
      this.categoryGroupName,
      this.phone,
      this.addressName,
      this.roadAddressName,
      this.x,
      this.y,
      this.placeUrl,
      this.distance);

  factory SearchKeywordDocument.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeywordDocumentToJson(this);
}
