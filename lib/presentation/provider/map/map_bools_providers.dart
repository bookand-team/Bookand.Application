import 'package:flutter_riverpod/flutter_riverpod.dart';

const bool show = true;
const bool hide = false;

//북마크 버튼에 따라 토글되는 state
class BookMarkToggleNotifier extends StateNotifier<bool> {
  BookMarkToggleNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final bookMarkToggleProvider =
    StateNotifierProvider<BookMarkToggleNotifier, bool>(
        (ref) => BookMarkToggleNotifier());

//gps 버튼에 따라 토글되는 state
class GpsToggleNotifier extends StateNotifier<bool> {
  GpsToggleNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final gpsToggleProvider = StateNotifierProvider<GpsToggleNotifier, bool>(
    (ref) => GpsToggleNotifier());

//search page에서 사용할 test state
class SearchNotifier extends StateNotifier<bool> {
  SearchNotifier() : super(false);
  void toggle() {
    state = !state;
  }
}

final searchProvider =
    StateNotifierProvider<SearchNotifier, bool>((ref) => SearchNotifier());

///map bottom sheet gesture에 따라 변경되는 search bar visible state
class SearchBarVisibleNotifier extends StateNotifier<bool> {
  SearchBarVisibleNotifier() : super(true);

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }
}

final searchBarShowProvider =
    StateNotifierProvider<SearchBarVisibleNotifier, bool>(
        (ref) => SearchBarVisibleNotifier());

///숨은 서점 버튼에 따라 토글되는 hide store visible state
class HideStoreToggleNotifier extends StateNotifier<bool> {
  HideStoreToggleNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final hideStoreToggleProvider =
    StateNotifierProvider<HideStoreToggleNotifier, bool>(
        (ref) => HideStoreToggleNotifier());

///theme 버튼 열고 있을 때 활성화 용
class ThemeToggleNotifier extends StateNotifier<bool> {
  ThemeToggleNotifier() : super(false);

  void toggle() {
    state = !state;
  }

  void activate() {
    state = true;
  }

  void deactivate() {
    state = false;
  }
}

final themeToggleProvider = StateNotifierProvider<ThemeToggleNotifier, bool>(
    (ref) => ThemeToggleNotifier());
