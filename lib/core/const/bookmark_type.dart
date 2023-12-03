import 'package:json_annotation/json_annotation.dart';

enum BookmarkType {
  @JsonValue('ARTICLE')
  article,
  @JsonValue('BOOKSTORE')
  bookstore
}

extension BookmarkServerStr on BookmarkType {
  String toServerString() {
    switch (this) {
      case BookmarkType.article:
        return 'ARTICLE';
      case BookmarkType.bookstore:
        return 'BOOKSTORE';
    }
  }
}
