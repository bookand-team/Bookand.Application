class BookmarkResultReponse {
  String? result;

  BookmarkResultReponse({this.result});

  BookmarkResultReponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    return data;
  }
}
