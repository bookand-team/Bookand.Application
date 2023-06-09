import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/domain/usecase/bookmark_usercae.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_store_provider.g.dart';

/// 북마크한 서점 리스트 가지고 있을 프로바이더
@Riverpod(keepAlive: true)
class BookmarkStoreNotifier extends _$BookmarkStoreNotifier {
  late BookmarkUsecase bookmarkUsecase;
  bool inited = false;
  @override
  List<BookmarkModel> build() {
    bookmarkUsecase = ref.read(bookmarkUsecaseProvider);
    return [];
  }

  Future<bool> init() async {
    if (!inited) {
      inited = true;
      final list = await bookmarkUsecase.initBookmarkStoreList();
      if (list != null) state = list;
    }
    return inited;
  }

  Future add(BookmarkModel model) async {
    await bookmarkUsecase.addBookmarkStore(model.bookmarkId!);
    addOnlyState(model);
  }

  Future delete(List<int> bookmarkIdList) async {
    await bookmarkUsecase.deleteBookmarkStoreList(idList: bookmarkIdList);
    deleteOnlyState(bookmarkIdList);
  }

  void addOnlyState(BookmarkModel model) async {
    state.add(model);
    state = List.from(state);
  }

  void deleteOnlyState(List<int> bookmarkIdList) async {
    state.removeWhere((element) => bookmarkIdList.contains(element.bookmarkId));
    state = List.from(state);
  }
}
