import 'package:bookand/core/const/bookmark_type.dart';
import 'package:json_annotation/json_annotation.dart';

class BookmarkIdsRequest {
  BookmarkType? bookmarkType;
  List<int>? contentIdList;

  BookmarkIdsRequest({required this.bookmarkType, required this.contentIdList});

  BookmarkIdsRequest.fromJson(Map<String, dynamic> json) {
    bookmarkType =
        $enumDecodeNullable(_$BookmarkTypeEnumMap, json['bookmarkType']);
    contentIdList = json['contentIdList'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookmarkType'] = _$BookmarkTypeEnumMap[bookmarkType];
    data['contentIdList'] = this.contentIdList;
    return data;
  }

  final _$BookmarkTypeEnumMap = {
    BookmarkType.article: 'ARTICLE',
    BookmarkType.bookstore: 'BOOKSTORE',
  };
}
