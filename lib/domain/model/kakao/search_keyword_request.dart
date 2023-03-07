import 'package:json_annotation/json_annotation.dart';

part 'search_keyword_request.g.dart';

@JsonSerializable()
class SearchKeywordRequest {
  final String query;
  @JsonKey(name: 'category_group_code')
  final String? categoryGroupCode;
  final String? x;
  final String? y;
  final int? radius;
  final String? rect;
  final int? page;
  final int? size;
  final String? sort;

  SearchKeywordRequest(
    this.query, {
    this.categoryGroupCode,
    this.x,
    this.y,
    this.radius,
    this.rect,
    this.page,
    this.size,
    this.sort,
  });

  factory SearchKeywordRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeywordRequestToJson(this);
}
