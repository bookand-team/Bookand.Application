import 'package:bookand/domain/model/kakao/search_keyword_response.dart';
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
  String query = '';
  String currentSearchKeyword = '';
  bool isLoading = false;

  @override
  SearchKeywordState build() => SearchKeywordState(searchList: [], selectedId: '');

  void searchKeyword() async {
    try {
      resetSearchResult();

      isLoading = true;

      if (query.isEmpty) return;

      searchKeywordResp = await ref.read(getKakaoSearchKeywordUseCaseProvider).getSearchList(query);
      currentSearchKeyword = query;

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
}
