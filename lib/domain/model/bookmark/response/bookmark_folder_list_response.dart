import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';

class BookmarkFolderListResponse {
  List<BookmarkFolderModel>? bookmarkFolderList;

  BookmarkFolderListResponse({this.bookmarkFolderList});

  BookmarkFolderListResponse.fromJson(Map<String, dynamic> json) {
    if (json['bookmarkFolderList'] != null) {
      bookmarkFolderList = <BookmarkFolderModel>[];
      json['bookmarkFolderList'].forEach((v) {
        bookmarkFolderList!.add(new BookmarkFolderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookmarkFolderList != null) {
      data['bookmarkFolderList'] =
          this.bookmarkFolderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
