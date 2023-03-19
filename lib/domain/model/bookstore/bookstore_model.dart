import 'package:json_annotation/json_annotation.dart';

part 'bookstore_model.g.dart';

@JsonSerializable()
class BookstoreModel {
  final List<BookstoreContent> content;
  final bool last;
  final int totalElements;
  final int totalPages;

  BookstoreModel(this.content, this.last, this.totalElements, this.totalPages);

  factory BookstoreModel.fromJson(Map<String, dynamic> json) => _$BookstoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookstoreModelToJson(this);
}

@JsonSerializable()
class BookstoreContent {
  final int id;
  final String introduction;
  final bool isBookmark;
  final String mainImage;
  final String name;
  final List<String> themeList;

  BookstoreContent(
      this.id, this.introduction, this.isBookmark, this.mainImage, this.name, this.themeList);

  factory BookstoreContent.fromJson(Map<String, dynamic> json) => _$BookstoreContentFromJson(json);

  Map<String, dynamic> toJson() => _$BookstoreContentToJson(this);
}
