import 'package:bookand/presentation/screen_logic/map/toggle_logic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//북마크 버튼에 따라 토글되는 state
class BookMarkToggleNotifier extends StateNotifier<bool>
    implements ToggleLogic {
  BookMarkToggleNotifier() : super(false);

  @override
  void toggle() {
    state = !state;
  }

  @override
  void activate() {
    state = true;
  }

  @override
  void deactivate() {
    state = false;
  }
}

final bookMarkToggleProvider =
    StateNotifierProvider<BookMarkToggleNotifier, bool>(
        (ref) => BookMarkToggleNotifier());

//gps 버튼에 따라 토글되는 state
class GpsToggleNotifier extends StateNotifier<bool> implements ToggleLogic {
  GpsToggleNotifier() : super(false);

  @override
  void toggle() {
    state = !state;
  }

  @override
  void activate() {
    state = true;
  }

  @override
  void deactivate() {
    state = false;
  }
}

final gpsToggleProvider = StateNotifierProvider<GpsToggleNotifier, bool>(
    (ref) => GpsToggleNotifier());

//search page에서 사용할 test state
class SearchToggleNotifier extends StateNotifier<bool> implements ToggleLogic {
  SearchToggleNotifier() : super(false);
  @override
  void toggle() {
    state = !state;
  }

  @override
  void activate() {
    state = true;
  }

  @override
  void deactivate() {
    state = false;
  }
}

final searchToggleProvider = StateNotifierProvider<SearchToggleNotifier, bool>(
    (ref) => SearchToggleNotifier());

///map bottom sheet gesture에 따라 변경되는 search bar visible state
class SearchBarToggleNotifier extends StateNotifier<bool>
    implements ToggleLogic {
  SearchBarToggleNotifier() : super(true);

  @override
  void toggle() {
    state = !state;
  }

  @override
  void activate() {
    state = true;
  }

  @override
  void deactivate() {
    state = false;
  }
}

final searchBarToggleProvider =
    StateNotifierProvider<SearchBarToggleNotifier, bool>(
        (ref) => SearchBarToggleNotifier());

///숨은 서점 버튼에 따라 토글되는 hide store visible state
class HideStoreToggleNotifier extends StateNotifier<bool>
    implements ToggleLogic {
  HideStoreToggleNotifier() : super(false);

  @override
  void toggle() {
    state = !state;
  }

  @override
  void activate() {
    state = true;
  }

  @override
  void deactivate() {
    state = false;
  }
}

final hideStoreToggleProvider =
    StateNotifierProvider<HideStoreToggleNotifier, bool>(
        (ref) => HideStoreToggleNotifier());

///theme 버튼 열고 있을 때 활성화 용
class ThemeToggleNotifier extends StateNotifier<bool> implements ToggleLogic {
  ThemeToggleNotifier() : super(false);

  @override
  void toggle() {
    state = !state;
  }

  @override
  void activate() {
    state = true;
  }

  @override
  void deactivate() {
    state = false;
  }
}

final themeToggleProvider = StateNotifierProvider<ThemeToggleNotifier, bool>(
    (ref) => ThemeToggleNotifier());
