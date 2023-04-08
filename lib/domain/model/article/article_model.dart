import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  final List<ArticleContent> content;
  final bool last;
  final int totalElements;
  final int totalPages;

  ArticleModel(this.content, this.last, this.totalElements, this.totalPages);

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}

@JsonSerializable()
class ArticleContent {
  final List<String> articleTagList;
  final String category;
  final String content;
  final String createdDate;
  final int id;
  bool isBookmark;
  final String mainImage;
  final String modifiedDate;
  final String status;
  final String title;
  final String subTitle;
  final int view;
  final bool visibility;
  final String writer;

  ArticleContent(
      this.articleTagList,
      this.category,
      this.content,
      this.createdDate,
      this.id,
      this.isBookmark,
      this.mainImage,
      this.modifiedDate,
      this.status,
      this.title,
      this.subTitle,
      this.view,
      this.visibility,
      this.writer);

  factory ArticleContent.fromJson(Map<String, dynamic> json) => _$ArticleContentFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleContentToJson(this);
}
