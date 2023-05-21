import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';
import 'package:bookand/domain/usecase/bookmark_usercae.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_ariticle_folders_provider.g.dart';

/// 아티클 폴더 리스트 가지고 있을 프로바이더
@Riverpod(keepAlive: true)
class BookmarkArticleFoldersNotifier extends _$BookmarkArticleFoldersNotifier {
  late BookmarkUsecase bookmarkUsecase;
  bool inited = false;
  @override
  List<BookmarkFolderModel> build() {
    bookmarkUsecase = ref.read(bookmarkUsecaseProvider);
    return [];
  }

  //서버로부터 데이터 받음
  Future<bool> init() async {
    if (!inited) {
      inited = true;
      final list = await bookmarkUsecase.initBookmarkArticleFolderList();
      if (list != null) state = list;
    }
    return inited;
  }

  Future addFolder(String name) async {
    int? id = await bookmarkUsecase.addBookmarkArticleFolder(folderName: name);
    state.insert(
        0,
        BookmarkFolderModel(
            bookmarkId: id,
            bookmarkType: BookmarkType.article,
            folderName: name));
    state = List.from(state);
  }

  Future updateName(int id, String newName) async {
    await bookmarkUsecase.updateBookmarkFolderName(
        folderId: id, newName: newName);
    final whereIter = state.where((element) => element.bookmarkId == id);
    if (whereIter.isNotEmpty) {
      final element = whereIter.first;
      element.folderName = newName;
      state = List.from(state);
    }
  }

  Future delete(int id) async {
    await bookmarkUsecase.delBookmarkFolder(folderId: id);
    state.removeWhere((element) => element.bookmarkId == id);
    state = List.from(state);
  }
}
