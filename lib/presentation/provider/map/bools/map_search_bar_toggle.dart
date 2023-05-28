import 'package:bookand/presentation/screen_logic/map/toggle_logic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///map bottom sheet gesture에 따라 변경되는 search bar visible state
class MapSearchBarToggleNotifier extends StateNotifier<bool>
    implements ToggleLogic {
  MapSearchBarToggleNotifier() : super(true);

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

final mapSearchBarToggleProvider =
    StateNotifierProvider<MapSearchBarToggleNotifier, bool>(
        (ref) => MapSearchBarToggleNotifier());
