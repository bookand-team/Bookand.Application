import 'package:bookand/presentation/screen_logic/map/toggle_logic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///theme 버튼 열고 있을 때 활성화 용
class ThemeToggleNotifier extends StateNotifier<bool> implements ToggleLogic {
  ThemeToggleNotifier() : super(false);

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

final themeToggleProvider = StateNotifierProvider<ThemeToggleNotifier, bool>(
    (ref) => ThemeToggleNotifier());
