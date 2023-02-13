import 'package:json_annotation/json_annotation.dart';

part 'article_entity.g.dart';

@JsonSerializable()
class ArticleEntity {
  final Article article;

  ArticleEntity(this.article);

  factory ArticleEntity.fromJson(Map<String, dynamic> json) => _$ArticleEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleEntityToJson(this);
}

@JsonSerializable()
class Article {
  final int totalPages;
  final int totalElements;
  final bool last;
  final List<Content> content;

  Article(this.totalPages, this.totalElements, this.last, this.content);

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Content {
  final int id;
  final String title;
  final String content;
  final String category;
  final String writer;
  final String status;
  final int view;
  final int bookmark;
  final String createdDate;
  final String modifiedDate;
  final bool visibility;
  final List<BookStoreList> bookStoreList;
  final Filter filter;

  Content(
      this.id,
      this.title,
      this.content,
      this.category,
      this.writer,
      this.status,
      this.view,
      this.bookmark,
      this.createdDate,
      this.modifiedDate,
      this.visibility,
      this.bookStoreList,
      this.filter);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class BookStoreList {
  final int id;
  final String name;
  final Info info;
  final String theme;
  final String introduction;
  final String mainImage;
  final List<SubImage> subImage;
  final String status;
  final int view;
  final int bookmark;
  final String createdDate;
  final String modifiedDate;
  final bool visibility;

  BookStoreList(
      this.id,
      this.name,
      this.info,
      this.theme,
      this.introduction,
      this.mainImage,
      this.subImage,
      this.status,
      this.view,
      this.bookmark,
      this.createdDate,
      this.modifiedDate,
      this.visibility);

  factory BookStoreList.fromJson(Map<String, dynamic> json) => _$BookStoreListFromJson(json);

  Map<String, dynamic> toJson() => _$BookStoreListToJson(this);
}

@JsonSerializable()
class Info {
  final String address;
  final String businessHours;
  final String contact;
  final String facility;
  final String sns;

  Info(this.address, this.businessHours, this.contact, this.facility, this.sns);

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class SubImage {
  final int id;
  final String bookStore;
  final String url;

  SubImage(this.id, this.bookStore, this.url);

  factory SubImage.fromJson(Map<String, dynamic> json) => _$SubImageFromJson(json);

  Map<String, dynamic> toJson() => _$SubImageToJson(this);
}

@JsonSerializable()
class Filter {
  final String deviceOS;
  final String memberId;

  Filter(this.deviceOS, this.memberId);

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);
}
