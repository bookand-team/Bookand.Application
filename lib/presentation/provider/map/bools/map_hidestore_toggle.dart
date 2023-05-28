import 'package:flutter_riverpod/flutter_riverpod.dart';

///숨은 서점 버튼에 따라 토글되는 hide store visible state
class HideStoreToggleNotifier extends StateNotifier<bool> {
  HideStoreToggleNotifier() : super(false);

  void toggle() {
    state = !state;
  }

  //hidestore bottomsheet 출력
  void activate() {
    state = true;
  }

  void deactivate() {
    state = false;
  }
}

final hideStoreToggleProvider =
    StateNotifierProvider<HideStoreToggleNotifier, bool>(
        (ref) => HideStoreToggleNotifier());
