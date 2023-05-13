import 'package:bookand/data/repository/bookmark_content_repository_impl.dart';
import 'package:bookand/data/repository/bookmark_folder_repository_impl.dart';
import 'package:bookand/domain/model/bookmark/bookmark_content_model.dart';
import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';
import 'package:bookand/domain/repository/bookmark_content_repository.dart';
import 'package:bookand/domain/repository/bookmark_folder_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/bookmark_type.dart';

part 'bookstroe_bookmark_usercae.g.dart';

@riverpod
BookstoreBookmarkUsecase bookstoreBookmarkUsecase(
    BookstoreBookmarkUsecaseRef ref) {
  final contentRepository = ref.read(bookmarkContentRepositoryProvider);
  final folderRepository = ref.read(bookmarkFolderRepositoryProvider);

  return BookstoreBookmarkUsecase(contentRepository, folderRepository);
}

///bookstore 북마크 페이지에서 사용되는 usecase 모음
class BookstoreBookmarkUsecase {
  BookmarkContentRepository contentRepository;
  BookmarkFolderRepository folderRepository;
  BookstoreBookmarkUsecase(this.contentRepository, this.folderRepository);

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

  Future<List<BookmarkContentModel>?> initBookmarkFolderContents(
      {required int folderId,
      cursorId = 0,
      int page = 0,
      int size = 10}) async {
    return await folderRepository.getBookmarkFolderContents(
        folderId: folderId, cursorId: cursorId, page: page, size: size);
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

  Future<List<BookmarkContentModel>?> initBookmarkArticleList(
      {int cursorId = 0, int page = 0, int size = 10}) async {
    return await contentRepository.getBookmarkContentList(
        type: BookmarkType.article);
  }

  Future<List<BookmarkContentModel>?> initBookmarkStoreList(
      {int cursorId = 0, int page = 0, int size = 10}) async {
    return await contentRepository.getBookmarkContentList(
        type: BookmarkType.bookstore);
  }

  //폴더, 모아보기 공용

  Future<bool?> deleteBookmarkArticleList({required List<int> idList}) async {
    return await contentRepository.deleteBookmarkContents(
        type: BookmarkType.article, idList: idList);
  }

  Future<bool?> deleteBookmarkStoreList({required List<int> idList}) async {
    return await contentRepository.deleteBookmarkContents(
        type: BookmarkType.bookstore, idList: idList);
  }
}
