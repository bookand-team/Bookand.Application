import 'package:bookand/domain/model/kakao/search_keyword_response.dart';
import 'package:bookand/domain/usecase/bookstore_report_use_case.dart';
import 'package:bookand/domain/usecase/get_kakao_search_keyword_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';

part 'new_bookstore_report_provider.g.dart';

class SearchKeywordState {
  List<SearchKeywordDocument> searchList;
  String selectedId;

  SearchKeywordState({
    required this.searchList,
    required this.selectedId,
  });

  SearchKeywordState copyWith({
    List<SearchKeywordDocument>? searchList,
    String? selectedId,
  }) {
    return SearchKeywordState(
      searchList: searchList ?? this.searchList,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}

@riverpod
class NewBookstoreReportStateNotifier extends _$NewBookstoreReportStateNotifier {
  SearchKeywordResponse? searchKeywordResp;
  int page = 0;
  String currentSearchKeyword = '';
  bool isLoading = false;

  @override
  SearchKeywordState build() => SearchKeywordState(searchList: [], selectedId: '');

  void searchKeyword(String searchText) async {
    try {
      resetSearchResult();

      isLoading = true;

      if (searchText.isEmpty) return;

      searchKeywordResp = await ref.read(getKakaoSearchKeywordUseCaseProvider).getSearchList(searchText);
      currentSearchKeyword = searchText;

      page = 1;

      state = state.copyWith(searchList: searchKeywordResp?.documents);
    } catch (e, stack) {
      logger.e(e, e, stack);
    } finally {
      isLoading = false;
    }
  }

  void nextSearchKeyword() async {
    try {
      searchKeywordResp = await ref
          .read(getKakaoSearchKeywordUseCaseProvider)
          .getSearchList(currentSearchKeyword, page: ++page);

      state = state.copyWith(searchList: [
        ...state.searchList,
        ...searchKeywordResp!.documents,
      ]);
    } catch (e, stack) {
      logger.e(e, e, stack);
    }
  }

  void resetSearchResult() {
    searchKeywordResp = null;
    currentSearchKeyword = '';
    page = 0;
    state = state.copyWith(searchList: [], selectedId: '');
  }

  bool hasSearchResult() {
    return searchKeywordResp?.documents.isEmpty ?? false;
  }

  bool isEnd() {
    return searchKeywordResp?.meta.isEnd ?? true;
  }

  void onTapSelectItem(String id) {
    if (state.selectedId == id) {
      state = state.copyWith(selectedId: '');
      return;
    }

    state = state.copyWith(selectedId: id);
  }

  bool isSelectedItem(String id) => state.selectedId == id;

  Future<void> bookstoreReport({
    required String name,
    required String address,
  }) async {
    await ref.read(bookstoreReportUseCaseProvider).bookstoreReport(name: name, address: address);
  }
}
