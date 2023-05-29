import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_search_bar_toggle.g.dart';

///map bottom sheet gesture에 따라 변경되는 search bar visible state
@Riverpod()
class MapSearchBarToggleNotifier extends _$MapSearchBarToggleNotifier {
  @override
  bool build() => true;

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

// final mapSearchBarToggleProvider =
//     StateNotifierProvider<MapSearchBarToggleNotifier, bool>(
//         (ref) => MapSearchBarToggleNotifier());
