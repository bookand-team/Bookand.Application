import 'package:bookand/domain/model/article/article_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookstore_detail.g.dart';

@JsonSerializable()
class BookstoreDetail {
  final List<ArticleContent> articleResponse;
  final String createdDate;
  final String displayDate;
  final int id;
  final BookstoreInfo info;
  final String introduction;
  bool isBookmark;
  final String mainImage;
  final String modifiedDate;
  final String name;
  final String status;
  final List<BookstoreSubImage> subImage;
  final List<String> themeList;
  final int view;
  final bool visibility;

  BookstoreDetail(
      this.articleResponse,
      this.createdDate,
      this.displayDate,
      this.id,
      this.info,
      this.introduction,
      this.isBookmark,
      this.mainImage,
      this.modifiedDate,
      this.name,
      this.status,
      this.subImage,
      this.themeList,
      this.view,
      this.visibility);

  factory BookstoreDetail.fromJson(Map<String, dynamic> json) => _$BookstoreDetailFromJson(json);

  Map<String, dynamic> toJson() => _$BookstoreDetailToJson(this);
}

@JsonSerializable()
class BookstoreInfo {
  final String address;
  final String businessHours;
  final String contact;
  final String facility;
  final String sns;

  BookstoreInfo(this.address, this.businessHours, this.contact, this.facility, this.sns);

  factory BookstoreInfo.fromJson(Map<String, dynamic> json) => _$BookstoreInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BookstoreInfoToJson(this);
}

@JsonSerializable()
class BookstoreSubImage {
  @JsonKey(name: 'bookStore')
  final String bookstore;
  final int id;
  final String url;

  BookstoreSubImage(this.bookstore, this.id, this.url);

  factory BookstoreSubImage.fromJson(Map<String, dynamic> json) =>
      _$BookstoreSubImageFromJson(json);

  Map<String, dynamic> toJson() => _$BookstoreSubImageToJson(this);
}
