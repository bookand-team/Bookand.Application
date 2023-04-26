import 'package:bookand/data/repository/kakao_repository_impl.dart';
import 'package:bookand/domain/model/kakao/search_keyword_response.dart';
import 'package:bookand/domain/usecase/bookstore_report_use_case.dart';
import 'package:easy_debounce/easy_debounce.dart';
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
  late final kakaoRepository = ref.read(kakaoRepositoryProvider);
  SearchKeywordResponse? searchKeywordResp;
  int page = 1;
  int size = 15;
  String currentSearchKeyword = '';

  @override
  SearchKeywordState build() => SearchKeywordState(searchList: [], selectedId: '');

  void onSearchTextChanged(String searchText) {
    EasyDebounce.debounce('bookstore_search', const Duration(milliseconds: 300), () async {
      searchKeyword(searchText);
    });
  }

  void searchKeyword(String searchText) async {
    try {
      if (searchText.isEmpty) {
        state = state.copyWith(searchList: []);
        return;
      }

      page = 1;
      searchKeywordResp = await kakaoRepository.searchKeyword(searchText, page, size);
      currentSearchKeyword = searchText;

      state = state.copyWith(searchList: searchKeywordResp?.documents);
    } catch (e, stack) {
      logger.e(e, e, stack);
    }
  }

  void nextSearchKeyword() async {
    try {
      searchKeywordResp = await kakaoRepository.searchKeyword(currentSearchKeyword, ++page, size);

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
