import 'package:bookand/core/const/bookmark_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_type_provider.g.dart';

/// 북마크 현재 타입
@Riverpod()
class BookmarkTypeNotifier extends _$BookmarkTypeNotifier {
  @override
  BookmarkType build() {
    return BookmarkType.bookstore;
  }

  void toBookstore() {
    state = BookmarkType.bookstore;
  }

  void toArticle() {
    state = BookmarkType.article;
  }
}
