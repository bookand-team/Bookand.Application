import 'package:flutter_riverpod/flutter_riverpod.dart';

final mapStateProvider = StateNotifierProvider<MapStateNotifier, MapState>(
    (ref) => MapStateNotifier());

class MapStateNotifier extends StateNotifier<MapState> {
  MapStateNotifier() : super(MapState()); // 초기 위치를 서울로 설정
  void toggleList() {
    state.list = !state.list;
  }

  void toggleGps() {
    state.gps = !state.gps;
  }

  void toggleSearch() {
    state.search = !state.search;
  }

  void updateHeight(double data) {
    state.height = data;
  }
}

class MapState {
  bool list = false;
  bool gps = false;
  bool search = false;
  double height = 0;
}

// class ListToggleNotifier extends StateNotifier<bool> {
//   ListToggleNotifier() : super(false);

//   void toggle() {
//     state = !state;
//   }
// }

// final listToggleProvider = StateNotifierProvider<ListToggleNotifier, bool>(
//     (ref) => ListToggleNotifier());

// class GpsToggleNotifier extends StateNotifier<bool> {
//   GpsToggleNotifier() : super(false);

//   void toggle() {
//     state = !state;
//   }
// }

// final gpsToggleProvider = StateNotifierProvider<GpsToggleNotifier, bool>(
//     (ref) => GpsToggleNotifier());

// class HeightNotifier extends StateNotifier<double> {
//   HeightNotifier() : super(0);

//   void updateHeight(double height) {
//     state = height;
//   }
// }

// final heightProvider =
//     StateNotifierProvider<HeightNotifier, double>((ref) => HeightNotifier());

// class SearchNotifier extends StateNotifier<bool> {
//   SearchNotifier() : super(false);
//   void toggle() {
//     state = !state;
//   }
// }

// final searchProvider =
//     StateNotifierProvider<SearchNotifier, bool>((ref) => SearchNotifier());
