//북마크 버튼에 따라 토글되는 state
import 'package:bookand/presentation/screen_logic/map/toggle_logic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
