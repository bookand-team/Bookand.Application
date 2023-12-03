import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';

class BookmarkFolderListResponse {
  List<BookmarkFolderModel>? bookmarkFolderList;

  BookmarkFolderListResponse({this.bookmarkFolderList});

  BookmarkFolderListResponse.fromJson(Map<String, dynamic> json) {
    if (json['bookmarkFolderList'] != null) {
      bookmarkFolderList = <BookmarkFolderModel>[];
      json['bookmarkFolderList'].forEach((v) {
        bookmarkFolderList!.add(BookmarkFolderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookmarkFolderList != null) {
      data['bookmarkFolderList'] =
          bookmarkFolderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
