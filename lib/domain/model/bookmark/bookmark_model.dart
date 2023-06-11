class BookmarkModel {
  int? bookmarkId;
  String? image;
  String? location;
  String? title;

  BookmarkModel({this.bookmarkId, this.image, this.location, this.title});

  BookmarkModel.fromJson(Map<String, dynamic> json) {
    bookmarkId = json['bookmarkId'];
    image = json['image'];
    location = json['location'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookmarkId'] = bookmarkId;
    data['image'] = image;
    data['location'] = location;
    data['title'] = title;
    return data;
  }
}
