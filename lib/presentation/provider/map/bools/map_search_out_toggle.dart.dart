import 'package:bookand/presentation/screen_logic/map/toggle_logic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//search page에서 검색을 한 건지 안한 건지
class MapSearchPageSearchedNotifier extends StateNotifier<bool>
    implements ToggleLogic {
  MapSearchPageSearchedNotifier() : super(false);
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

final mapSearchPageSearchedProvider =
    StateNotifierProvider<MapSearchPageSearchedNotifier, bool>(
        (ref) => MapSearchPageSearchedNotifier());
