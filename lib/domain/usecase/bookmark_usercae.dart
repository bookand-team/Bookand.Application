import 'package:bookand/data/repository/bookmark_folder_repository_impl.dart';
import 'package:bookand/data/repository/bookmark_repository_impl.dart';
import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/domain/repository/bookmark_folder_repository.dart';
import 'package:bookand/domain/repository/bookmark_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/bookmark_type.dart';

part 'bookmark_usercae.g.dart';

@riverpod
BookmarkUsecase bookmarkUsecase(BookmarkUsecaseRef ref) {
  final bookmarkRepository = ref.read(bookmarkRepositoryProvider);
  final folderRepository = ref.read(bookmarkFolderRepositoryProvider);

  return BookmarkUsecase(folderRepository, bookmarkRepository);
}

///bookstore 북마크 페이지에서 사용되는 usecase 모음
class BookmarkUsecase {
  BookmarkFolderRepository folderRepository;
  BookmarkRepository bookmarkRepository;
  BookmarkUsecase(this.folderRepository, this.bookmarkRepository);

  //북마크 기본

  Future addBookmarkArticle(int id) async {
    await bookmarkRepository.addArticleBookmark(id);
  }

  Future addBookmarkStore(int id) async {
    await bookmarkRepository.addBookstoreBookmark(id);
  }

  Future<bool?> deleteBookmarkArticleList({required List<int> idList}) async {
    return await bookmarkRepository.deleteBookmarkContents(
        type: BookmarkType.article, idList: idList);
  }

  Future<bool?> deleteBookmarkStoreList({required List<int> idList}) async {
    return await bookmarkRepository.deleteBookmarkContents(
        type: BookmarkType.bookstore, idList: idList);
  }

  //폴더

  Future<List<BookmarkFolderModel>?> initBookmarkArticleFolderList() async {
    return await folderRepository.getBookmarkFolderList(BookmarkType.article);
  }

  Future<List<BookmarkFolderModel>?> initBookmarkStoreFolderList() async {
    return await folderRepository.getBookmarkFolderList(BookmarkType.bookstore);
  }

  Future<int?> addBookmarkArticleFolder({required String folderName}) async {
    return await folderRepository.addBookmarkFolder(
        type: BookmarkType.article, name: folderName);
  }

  Future<int?> addBookmarkStoreFolder({required String folderName}) async {
    return await folderRepository.addBookmarkFolder(
        type: BookmarkType.bookstore, name: folderName);
  }

  Future<int?> updateBookmarkFolderName(
      {required int folderId, required String newName}) async {
    return await folderRepository.updateBookmarkFolderName(
        folderId: folderId, newName: newName);
  }

  Future<bool?> delBookmarkFolder({required int folderId}) async {
    return await folderRepository.deleteBookmarkFolder(folderId: folderId);
  }

  //폴더 내부

  Future<List<BookmarkModel>?> initBookmarkFolderContents(
      {required int folderId,
      cursorId = 0,
      int page = 0,
      int size = 10}) async {
    return await folderRepository.getBookmarkFolderContents(
        folderId: folderId, cursorId: cursorId, page: page, size: size);
  }

  Future<int?> addBookmarkArticleFolderContent(
      {required int folderId, required List<int> contentsIdList}) async {
    return await folderRepository.addBookmarkFolderContents(
        folderId: folderId, type: BookmarkType.article, idList: contentsIdList);
  }

  Future<int?> addBookmarkStoreFolderContent(
      {required int folderId, required List<int> contentsIdList}) async {
    return await folderRepository.addBookmarkFolderContents(
        folderId: folderId,
        type: BookmarkType.bookstore,
        idList: contentsIdList);
  }

  Future<bool?> delBookmarkArticleFolderContent(
      {required int folderId, required List<int> contentsIdList}) async {
    return await folderRepository.deleteBookmarkFolderContents(
        folderId: folderId,
        type: BookmarkType.bookstore,
        idList: contentsIdList);
  }

  Future<bool?> delBookmarkStoreFolderContent(
      {required int folderId, required List<int> contentsIdList}) async {
    return await folderRepository.deleteBookmarkFolderContents(
        folderId: folderId,
        type: BookmarkType.bookstore,
        idList: contentsIdList);
  }

  //모아보기

  Future<List<BookmarkModel>?> initBookmarkArticleList(
      {int cursorId = 0, int page = 0, int size = 10}) async {
    return await bookmarkRepository.getBookmarkList(type: BookmarkType.article);
  }

  Future<List<BookmarkModel>?> initBookmarkStoreList(
      {int cursorId = 0, int page = 0, int size = 10}) async {
    return await bookmarkRepository.getBookmarkList(
        type: BookmarkType.bookstore);
  }
}
