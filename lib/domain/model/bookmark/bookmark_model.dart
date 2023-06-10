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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookmarkId'] = this.bookmarkId;
    data['image'] = this.image;
    data['location'] = this.location;
    data['title'] = this.title;
    return data;
  }
}