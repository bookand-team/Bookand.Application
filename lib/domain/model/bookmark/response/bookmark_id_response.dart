class BookmarkIdReponse {
  int? bookmarkId;

  BookmarkIdReponse({this.bookmarkId});

  BookmarkIdReponse.fromJson(Map<String, dynamic> json) {
    bookmarkId = json['bookmarkId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookmarkId'] = bookmarkId;
    return data;
  }
}
