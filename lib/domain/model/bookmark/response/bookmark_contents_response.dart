import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/domain/model/bookmark/bookmark_content_model.dart';
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
        ? new BookmarkInfo.fromJson(json['bookmarkInfo'])
        : null;
    bookmarkType =
        $enumDecodeNullable(_$BookmarkTypeEnumMap, json['bookmarkType']);
    folderName = json['folderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookmarkId'] = this.bookmarkId;
    data['bookmarkImage'] = this.bookmarkImage;
    if (this.bookmarkInfo != null) {
      data['bookmarkInfo'] = this.bookmarkInfo!.toJson();
    }
    data['bookmarkType'] = _$BookmarkTypeEnumMap[bookmarkType];
    data['folderName'] = this.folderName;
    return data;
  }

  final _$BookmarkTypeEnumMap = {
    BookmarkType.article: 'ARTICLE',
    BookmarkType.bookstore: 'BOOKSTORE',
  };
}

class BookmarkInfo {
  List<BookmarkContentModel>? content;
  bool? last;
  int? totalElements;
  int? totalPages;

  BookmarkInfo({this.content, this.last, this.totalElements, this.totalPages});

  BookmarkInfo.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <BookmarkContentModel>[];
      json['content'].forEach((v) {
        content!.add(new BookmarkContentModel.fromJson(v));
      });
    }
    last = json['last'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['last'] = this.last;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    return data;
  }
}
