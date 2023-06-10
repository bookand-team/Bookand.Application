import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_theme_toggle.g.dart';

///theme 버튼 열고 있을 때 활성화 용
@Riverpod()
class ThemeToggleNotifier extends _$ThemeToggleNotifier {
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

// final themeToggleProvider = StateNotifierProvider<ThemeToggleNotifier, bool>(
//     (ref) => ThemeToggleNotifier());
