import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListToggleNotifier extends StateNotifier<bool> {
  StateNotifierProviderRef ref;
  late HeightNotifier heightCon;
  late PanelHeightNotifier panelHeightNotifier;
  ListToggleNotifier(this.ref) : super(false) {
    heightCon = ref.read(heightProvider.notifier);
    panelHeightNotifier = ref.read(panelHeightProvider.notifier);
  }

  void toggle() {
    if (state) {
      heightCon.updateHeight(0);
    } else {
      heightCon.initHeight();
      panelHeightNotifier.init();
    }
    state = !state;
  }
}

final listToggleProvider = StateNotifierProvider<ListToggleNotifier, bool>(
    (ref) => ListToggleNotifier(ref));

class GpsToggleNotifier extends StateNotifier<bool> {
  GpsToggleNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final gpsToggleProvider = StateNotifierProvider<GpsToggleNotifier, bool>(
    (ref) => GpsToggleNotifier());

class ButtonHeightNotifier extends StateNotifier<double> {
  ButtonHeightNotifier() : super(0);
  static const double initheight = 200;

//리스트 버튼 눌러야
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
