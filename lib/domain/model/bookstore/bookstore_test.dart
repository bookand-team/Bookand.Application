import 'package:json_annotation/json_annotation.dart';

part 'bookstore_test.g.dart';

///처음에 전부 받을 때를 가정한 bookstore model
///현재 받는 건 id, bookmark, image s3 path, name, socialLink, themeList등 더 있을 듯 
@JsonSerializable()
class BookstoreTest {
  final int id;
  final String introduction;
  bool isBookmark;
  final String mainImage;
  final String name;
  final String socialLink;
  final List<String> themeList;

  BookstoreTest(
      this.id, this.introduction, this.isBookmark, this.mainImage, this.name, this.themeList, this.socialLink);

  factory BookstoreTest.fromJson(Map<String, dynamic> json) => _$BookstoreTestFromJson(json);

  Map<String, dynamic> toJson() => _$BookstoreTestToJson(this);
}
