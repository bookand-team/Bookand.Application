import 'package:json_annotation/json_annotation.dart';

import '../bookstore/bookstore_model.dart';

part 'article_detail.g.dart';

@JsonSerializable()
class ArticleDetail {
  final List<String>? articleTagList;
  @JsonKey(name: 'bookStoreList')
  final List<BookstoreContent>? bookstoreList;
  final bool? bookmark;
  final int? bookmarkCount;
  final String? category;
  final String? content;
  final String? createdDate;
  final String? displayDate;
  final ArticleFilter? filter;
  final int? id;
  final String? mainImage;
  final String? modifiedDate;
  final String? status;
  final String? title;
  final String? subTitle;
  final int? view;
  final bool? visibility;
  final String? writer;

  ArticleDetail(
      {this.articleTagList,
      this.bookstoreList,
      this.bookmark,
      this.bookmarkCount,
      this.category,
      this.content,
      this.createdDate,
      this.displayDate,
      this.filter,
      this.id,
      this.mainImage,
      this.modifiedDate,
      this.status,
      this.title,
      this.subTitle,
      this.view,
      this.visibility,
      this.writer});

  ArticleDetail copyWith({
    List<String>? articleTagList,
    List<BookstoreContent>? bookstoreList,
    bool? bookmark,
    int? bookmarkCount,
    String? category,
    String? content,
    String? createdDate,
    String? displayDate,
    ArticleFilter? filter,
    int? id,
    String? mainImage,
    String? modifiedDate,
    String? status,
    String? title,
    String? subTitle,
    int? view,
    bool? visibility,
    String? writer,
  }) {
    return ArticleDetail(
      articleTagList: articleTagList ?? this.articleTagList,
      bookstoreList: bookstoreList ?? this.bookstoreList,
      bookmark: bookmark ?? this.bookmark,
      bookmarkCount: bookmarkCount ?? this.bookmarkCount,
      category: category ?? this.category,
      content: content ?? this.content,
      createdDate: createdDate ?? this.createdDate,
      displayDate: displayDate ?? this.displayDate,
      filter: filter ?? this.filter,
      id: id ?? this.id,
      mainImage: mainImage ?? this.mainImage,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      status: status ?? this.status,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      view: view ?? this.view,
      visibility: visibility ?? this.visibility,
      writer: writer ?? this.writer,
    );
  }

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
