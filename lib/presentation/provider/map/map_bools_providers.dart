import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'map_state_proivders.dart';

// 패널을 보일지 말지 결정, 껏다 키며 버튼 높이 조절
class PanelVisibleNotifier extends StateNotifier<bool> {
  StateNotifierProviderRef ref;
  late ButtonHeightNotifier buttonHeightCon;
  PanelVisibleNotifier(this.ref) : super(false) {
    buttonHeightCon = ref.read(buttonHeightProvider.notifier);
  }

  void toggle() {
    // 켰을 때
    if (!state) {
      buttonHeightCon.toPanel();
    }
    // 껐을 때
    else {
      buttonHeightCon.toBottom();
    }
    state = !state;
  }
}

final panelVisibleProvider = StateNotifierProvider<PanelVisibleNotifier, bool>(
    (ref) => PanelVisibleNotifier(ref));

class BookMarkToggleNotifier extends StateNotifier<bool> {
  BookMarkToggleNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final bookMarkToggleProvider =
    StateNotifierProvider<BookMarkToggleNotifier, bool>(
        (ref) => BookMarkToggleNotifier());

class GpsToggleNotifier extends StateNotifier<bool> {
  GpsToggleNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final gpsToggleProvider = StateNotifierProvider<GpsToggleNotifier, bool>(
    (ref) => GpsToggleNotifier());

class SearchNotifier extends StateNotifier<bool> {
  SearchNotifier() : super(false);
  void toggle() {
    state = !state;
  }
}

final searchProvider =
    StateNotifierProvider<SearchNotifier, bool>((ref) => SearchNotifier());

class SearchBarShow extends StateNotifier<bool> {
  SearchBarShow() : super(true);

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }
}

final searchBarShowProvider =
    StateNotifierProvider<SearchBarShow, bool>((ref) => SearchBarShow());
