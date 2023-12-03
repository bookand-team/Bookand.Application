import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:json_annotation/json_annotation.dart';

class BookmarkContentsReponse {
  int? bookmarkId;
  String? bookmarkImage;
  BookmarkInfo? bookmarkInfo;
  BookmarkType? bookmarkType;
  String? folderName;

  BookmarkContentsReponse(
      {this.bookmarkId,
      this.bookmarkImage,
      this.bookmarkInfo,
      this.bookmarkType,
      this.folderName});

  BookmarkContentsReponse.fromJson(Map<String, dynamic> json) {
    bookmarkId = json['bookmarkId'];
    bookmarkImage = json['bookmarkImage'];
    bookmarkInfo = json['bookmarkInfo'] != null
        ? BookmarkInfo.fromJson(json['bookmarkInfo'])
        : null;
    bookmarkType =
        $enumDecodeNullable(_$BookmarkTypeEnumMap, json['bookmarkType']);
    folderName = json['folderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookmarkId'] = bookmarkId;
    data['bookmarkImage'] = bookmarkImage;
    if (bookmarkInfo != null) {
      data['bookmarkInfo'] = bookmarkInfo!.toJson();
    }
    data['bookmarkType'] = _$BookmarkTypeEnumMap[bookmarkType];
    data['folderName'] = folderName;
    return data;
  }

  final _$BookmarkTypeEnumMap = {
    BookmarkType.article: 'ARTICLE',
    BookmarkType.bookstore: 'BOOKSTORE',
  };
}

class BookmarkInfo {
  List<BookmarkModel>? content;
  bool? last;
  int? totalElements;
  int? totalPages;

  BookmarkInfo({this.content, this.last, this.totalElements, this.totalPages});

  BookmarkInfo.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <BookmarkModel>[];
      json['content'].forEach((v) {
        content!.add(BookmarkModel.fromJson(v));
      });
    }
    last = json['last'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    data['last'] = last;
    data['totalElements'] = totalElements;
    data['totalPages'] = totalPages;
    return data;
  }
}
