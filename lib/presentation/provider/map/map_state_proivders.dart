import 'package:flutter_riverpod/flutter_riverpod.dart';

// 패널을 보일지 말지 결정, 껏다 키며 버튼 높이 조절
class ShowPanelNotifier extends StateNotifier<bool> {
  StateNotifierProviderRef ref;
  late ButtonHeightNotifier buttonHeightCon;
  late PanelHeightNotifier panelHeightCon;
  ShowPanelNotifier(this.ref) : super(false) {
    buttonHeightCon = ref.read(buttonHeightProvider.notifier);
    panelHeightCon = ref.read(panelHeightProvider.notifier);
  }

  void toggle() {
    state = !state;
    // 켰을 때
    if (state) {
      buttonHeightCon.initHeight();
      panelHeightCon.init();
    }
    // 켰을 때
    else {
      buttonHeightCon.updateHeight(0);
    }
  }
}

final showPanelProvider = StateNotifierProvider<ShowPanelNotifier, bool>(
    (ref) => ShowPanelNotifier(ref));

enum ListType { list, showHide, theme, none }

//작동 방식 show state 변경 -> show panel toggle
class ListTypeNotifier extends StateNotifier<ListType> {
  StateNotifierProviderRef ref;
  late ShowPanelNotifier showPanelCon;

  ListTypeNotifier(this.ref) : super(ListType.none) {
    showPanelCon = ref.read(showPanelProvider.notifier);
  }
  void toggle(ListType type) {
    state = (state == type) ? ListType.none : type;
  }

  toggleTheme() {
    toggle(ListType.theme);
    showPanelCon.toggle();
  }

  toggleShowHide() {
    toggle(ListType.showHide);
    showPanelCon.toggle();
  }

  toggleList() {
    toggle(ListType.list);
    showPanelCon.toggle();
  }
}

final listTypeProvider = StateNotifierProvider<ListTypeNotifier, ListType>(
    (ref) => ListTypeNotifier(ref));

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

//패널 위의 버튼 조절
class ButtonHeightNotifier extends StateNotifier<double> {
  ButtonHeightNotifier() : super(0);
  static const double initheight = 200;

  //패널 꺼졌을 때
  void initZero() {
    state = 0;
  }

  //패널 처음 높이로 조절
  void initHeight() {
    state = initheight;
  }

  void updateHeight(double height) {
    if (height >= 0) {
      state = height;
    }
  }

  void updateHeightDelta(double delta) {
    if (state + delta >= 0) {
      state += delta;
    }
  }
}

final buttonHeightProvider =
    StateNotifierProvider<ButtonHeightNotifier, double>(
        (ref) => ButtonHeightNotifier());

class SearchNotifier extends StateNotifier<bool> {
  SearchNotifier() : super(false);
  void toggle() {
    state = !state;
  }
}

final searchProvider =
    StateNotifierProvider<SearchNotifier, bool>((ref) => SearchNotifier());

//패널 height 조절
class PanelHeightNotifier extends StateNotifier<double> {
  PanelHeightNotifier() : super(200);
  static const double initHeight = 200;
  void updateHeight(double value) {
    state = value;
  }

  void updateHeightDelta(double value) {
    if (state + value > 0) {
      state += value;
    }
  }

  void init() {
    state = initHeight;
  }
}

final panelHeightProvider = StateNotifierProvider<PanelHeightNotifier, double>(
    (ref) => PanelHeightNotifier());

class SearchBarShow extends StateNotifier<bool> {
  SearchBarShow() : super(true);

  void show() {
    state = true;
  }

  void notShow() {
    state = false;
  }
}

final searchBarShowProvider =
    StateNotifierProvider<SearchBarShow, bool>((ref) => SearchBarShow());

enum CustomPanelState { opend, scroll, closed }

class PanelStateNotifier extends StateNotifier<CustomPanelState> {
  PanelStateNotifier() : super(CustomPanelState.closed);
  updateState(CustomPanelState newState) {
    if (state != newState) {
      state = newState;
    }
  }
}

final panelStateProvider =
    StateNotifierProvider<PanelStateNotifier, CustomPanelState>(
        (ref) => PanelStateNotifier());
