import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_search_out_toggle.dart.g.dart';

//search page에서 검색을 한 건지 안한 건지
@Riverpod()
class MapSearchPageSearchedNotifier extends _$MapSearchPageSearchedNotifier {
  @override
  bool build() => false;

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

// final mapSearchPageSearchedProvider =
//     StateNotifierProvider<MapSearchPageSearchedNotifier, bool>(
//         (ref) => MapSearchPageSearchedNotifier());
