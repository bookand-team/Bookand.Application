import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookstore_map_model.g.dart';

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
  String? address;
  List<Themes>? theme;

  BookStoreMapModel(
      {this.id,
      this.isBookmark,
      this.latitude,
      this.longitude,
      this.mainImage,
      this.name,
      this.address,
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
