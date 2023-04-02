import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'map_bools_providers.dart';

enum ListType { list, showHide, theme }

//작동 방식 show state 변경 -> show panel toggle
class ListTypeNotifier extends StateNotifier<ListType> {
  StateNotifierProviderRef ref;
  late PanelVisibleNotifier showPanelCon;

  ListTypeNotifier(this.ref) : super(ListType.list) {
    showPanelCon = ref.read(panelVisibleProvider.notifier);
  }
  void toggle(ListType type) {
    state = (state == type) ? ListType.list : type;
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

//패널 위의 버튼 조절
class ButtonHeightNotifier extends StateNotifier<double> {
  ButtonHeightNotifier() : super(0);
  static const double initheight = 200;

  //패널 꺼졌을 때
  void initZero() {
    state = 0;
  }

  void toPanel() {
    state = initheight;
  }

  void toBottom() {
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

enum CustomPanelState { opend, scrolling, closed }

class PanelStateNotifier extends StateNotifier<CustomPanelState> {
  PanelStateNotifier() : super(CustomPanelState.closed);
  updateState(CustomPanelState newState) {
    print(state);
    if (state != newState) {
      state = newState;
      print('panel state change = ' + state.toString());
    }
  }
}

final panelStateProvider =
    StateNotifierProvider<PanelStateNotifier, CustomPanelState>(
        (ref) => PanelStateNotifier());
