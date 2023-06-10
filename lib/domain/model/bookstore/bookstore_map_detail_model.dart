import 'package:bookand/domain/model/article/article_model.dart';
import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookstore_map_detail_model.g.dart';

@JsonSerializable()
class BookstoreMapDetailModel {
  final List<ArticleContent>? articleResponse;
  final String? createdDate;
  final String? displayDate;
  final int? id;
  final BookstoreMapInfoModel? info;
  final String? introduction;
  bool? isBookmark;
  final String? mainImage;
  final String? modifiedDate;
  final String? name;
  final String? status;
  final List<BookstoreMapSubImageModel>? subImage;
  final List<Themes>? themeList;
  final int? view;
  final bool? visibility;

  BookstoreMapDetailModel(
      {this.articleResponse,
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
      this.visibility});

  BookstoreMapDetailModel copyWith({
    List<ArticleContent>? articleResponse,
    String? createdDate,
    String? displayDate,
    int? id,
    BookstoreMapInfoModel? info,
    String? introduction,
    bool? isBookmark,
    String? mainImage,
    String? modifiedDate,
    String? name,
    String? status,
    List<BookstoreMapSubImageModel>? subImage,
    List<Themes>? themeList,
    int? view,
    bool? visibility,
  }) {
    return BookstoreMapDetailModel(
      articleResponse: articleResponse ?? this.articleResponse,
      createdDate: createdDate ?? this.createdDate,
      displayDate: displayDate ?? this.displayDate,
      id: id ?? this.id,
      info: info ?? this.info,
      introduction: introduction ?? this.introduction,
      isBookmark: isBookmark ?? this.isBookmark,
      mainImage: mainImage ?? this.mainImage,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      name: name ?? this.name,
      status: status ?? this.status,
      subImage: subImage ?? this.subImage,
      themeList: themeList ?? this.themeList,
      view: view ?? this.view,
      visibility: visibility ?? this.visibility,
    );
  }

  factory BookstoreMapDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BookstoreMapDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookstoreMapDetailModelToJson(this);
  @override
  String toString() {
    return 'BookstoreMapDetailModel' + toJson().toString();
  }
}

@JsonSerializable()
class BookstoreMapInfoModel {
  final String? address;
  final String? businessHours;
  final String? contact;
  final String? facility;
  final String? sns;
  @JsonKey(fromJson: _fromJsonDoule)
  final double? latitude;
  @JsonKey(fromJson: _fromJsonDoule)
  final double? longitude;

  BookstoreMapInfoModel(this.address, this.businessHours, this.contact,
      this.facility, this.sns, this.latitude, this.longitude);
  static double? _fromJsonDoule(dynamic data) {
    if (data == null) {
      return null;
    } else {
      return double.parse(data as String);
    }
  }

  factory BookstoreMapInfoModel.fromJson(Map<String, dynamic> json) =>
      _$BookstoreMapInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookstoreMapInfoModelToJson(this);
  @override
  String toString() {
    return 'BookstoreMapInfoModel' + toJson().toString();
  }
}

@JsonSerializable()
class BookstoreMapSubImageModel {
  @JsonKey(name: 'bookStore')
  final String bookstore;
  final int id;
  final String url;

  BookstoreMapSubImageModel(this.bookstore, this.id, this.url);

  factory BookstoreMapSubImageModel.fromJson(Map<String, dynamic> json) =>
      _$BookstoreMapSubImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookstoreMapSubImageModelToJson(this);
  @override
  String toString() {
    return 'BookstoreMapSubImageModel' + toJson().toString();
  }
}
