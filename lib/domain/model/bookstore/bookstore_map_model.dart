import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookstore_map_model.g.dart';

class BookStoreGetAllResponse {
  List<BookStoreMapModel>? bookStoreAddressListResponse;

  BookStoreGetAllResponse({this.bookStoreAddressListResponse});

  BookStoreGetAllResponse.fromJson(Map<String, dynamic> json) {
    if (json['bookStoreAddressListResponse'] != null) {
      bookStoreAddressListResponse = <BookStoreMapModel>[];
      json['bookStoreAddressListResponse'].forEach((v) {
        bookStoreAddressListResponse!.add(new BookStoreMapModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookStoreAddressListResponse != null) {
      data['bookStoreAddressListResponse'] =
          this.bookStoreAddressListResponse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@JsonSerializable()
class BookStoreMapModel {
  int? id;
  bool? isBookmark;
  @JsonKey(fromJson: _fromJsonDoule)
  double? latitude;
  @JsonKey(fromJson: _fromJsonDoule)
  double? longitude;
  double? userDistance;
  String? mainImage;
  String? name;
  List<Themes>? theme;

  BookStoreMapModel(
      {this.id,
      this.isBookmark,
      this.latitude,
      this.longitude,
      this.mainImage,
      this.name,
      this.userDistance = 0,
      this.theme});

  factory BookStoreMapModel.fromJson(Map<String, dynamic> json) =>
      _$BookStoreMapModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookStoreMapModelToJson(this);

  @override
  String toString() {
    return 'BookStoreMapModel' + toJson().toString();
  }

  static double? _fromJsonDoule(dynamic data) {
    if (data == null) {
      return null;
    } else {
      return double.parse(data as String);
    }
  }
}
