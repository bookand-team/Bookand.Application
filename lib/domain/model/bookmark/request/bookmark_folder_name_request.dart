import 'package:json_annotation/json_annotation.dart';

import '../../../../core/const/bookmark_type.dart';

class BookmarkFolderNameRequest {
  BookmarkType? bookmarkType;
  String? folderName;

  BookmarkFolderNameRequest({this.bookmarkType, this.folderName});

  BookmarkFolderNameRequest.fromJson(Map<String, dynamic> json) {
    bookmarkType =
        $enumDecodeNullable(_$BookmarkTypeEnumMap, json['bookmarkType']);

    folderName = json['folderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookmarkType'] = _$BookmarkTypeEnumMap[bookmarkType];
    data['folderName'] = this.folderName;
    return data;
  }

  final _$BookmarkTypeEnumMap = {
    BookmarkType.article: 'ARTICLE',
    BookmarkType.bookstore: 'BOOKSTORE',
  };
}
