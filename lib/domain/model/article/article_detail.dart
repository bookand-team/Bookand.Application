import 'package:json_annotation/json_annotation.dart';

import '../bookstore/bookstore_model.dart';

part 'article_detail.g.dart';

@JsonSerializable()
class ArticleDetail {
  final List<String> articleTagList;
  @JsonValue('bookStoreList')
  final List<BookstoreContent> bookstoreList;
  final bool bookmark;
  final int bookmarkCount;
  final String category;
  final String content;
  final String createdDate;
  final String displayData;
  final ArticleFilter filter;
  final int id;
  final String mainImage;
  final String modifiedDate;
  final String status;
  final String title;
  final int view;
  final bool visibility;
  final String writer;

  ArticleDetail(
      this.articleTagList,
      this.bookstoreList,
      this.bookmark,
      this.bookmarkCount,
      this.category,
      this.content,
      this.createdDate,
      this.displayData,
      this.filter,
      this.id,
      this.mainImage,
      this.modifiedDate,
      this.status,
      this.title,
      this.view,
      this.visibility,
      this.writer);

  factory ArticleDetail.fromJson(Map<String, dynamic> json) => _$ArticleDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDetailToJson(this);
}

@JsonSerializable()
class ArticleFilter {
  final String deviceOS;
  final String memberId;

  ArticleFilter(this.deviceOS, this.memberId);

  factory ArticleFilter.fromJson(Map<String, dynamic> json) => _$ArticleFilterFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleFilterToJson(this);
}
