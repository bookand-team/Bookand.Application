import 'package:bookand/data/repository/bookmark_repository_impl.dart';
import 'package:bookand/domain/repository/bookmark_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/bookmark_type.dart';

part 'delete_bookmark_use_case.g.dart';

@riverpod
DeleteBookmarkUseCase deleteBookmarkUseCase(DeleteBookmarkUseCaseRef ref) {
  final bookmarkRepository = ref.read(bookmarkRepositoryProvider);
  return DeleteBookmarkUseCase(bookmarkRepository);
}

class DeleteBookmarkUseCase {
  final BookmarkRepository bookmarkRepository;

  DeleteBookmarkUseCase(this.bookmarkRepository);

  Future<void> deleteBookmarkArticleList(List<int> idList) async {
    await bookmarkRepository.deleteBookmark(BookmarkType.article, idList);
  }

  Future<void> deleteBookmarkBookstoreList(List<int> idList) async {
    await bookmarkRepository.deleteBookmark(BookmarkType.bookstore, idList);
  }
}
