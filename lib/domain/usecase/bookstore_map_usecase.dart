import 'package:bookand/data/repository/bookmark_repository_impl.dart';
import 'package:bookand/data/repository/bookstore_map_repository_impl.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_detail_model.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/domain/repository/bookmark_repository.dart';
import 'package:bookand/domain/repository/bookstore_map_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookstore_map_usecase.g.dart';

@riverpod
BookstoreMapUsecase bookstoreMapUsecase(BookstoreMapUsecaseRef ref) {
  final bookstoreMapRepository = ref.read(bookstoreMapRepositoryProvider);
  final bookmarkRepository = ref.read(bookmarkRepositoryProvider);
  return BookstoreMapUsecase(bookstoreMapRepository, bookmarkRepository);
}

///bookstore 맵에서 사용되는 usecase 모음
class BookstoreMapUsecase {
  final BookstoreMapRepository bookstoreMapRepository;
  final BookmarkRepository bookmarkRepository;

  BookstoreMapUsecase(
    this.bookstoreMapRepository,
    this.bookmarkRepository,
  );

  Future<BookStoreGetAllResponse> getBookstores() async {
    return await bookstoreMapRepository.getBookstoreAll();
  }

  Future toggleBookstoreBookmark(int id) async {
    return await bookmarkRepository.addBookstoreBookmark(id);
  }

  Future<BookstoreMapDetailModel> getBookstoreMapDetail(int id) async {
    return bookstoreMapRepository.getBookstoreMapDetail(id);
  }
}
