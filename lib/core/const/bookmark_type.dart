import 'package:json_annotation/json_annotation.dart';

enum BookmarkType {
  @JsonValue('ARTICLE')
  article,
  @JsonValue('BOOKSTORE')
  bookstore
}
