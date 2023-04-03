import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_theme_provider.g.dart';

@Riverpod()
class MapThemeNotifier extends _$MapThemeNotifier {
  @override
  List<String> build() => [];
  //옵션
  static const List<String> options = [
    '여행',
    '음악',
    '그림',
    '애완동물',
    '영화',
    '추리',
    '역사'
  ];

  /// option이 state에 있으면 제거 없으면 추가
  // void toggleTheme(String theme) {
  //   //안전성 점검
  //   if (options.contains(theme)) {
  //     if (state.contains(theme)) {
  //       state = List.from(state..remove(theme));
  //     } else {
  //       state = List.from(state..add(theme));
  //     }
  //   }
  // }

  void addThemes(List<String> selectedThemes) {
    state = selectedThemes;
  }

  void initThemes() {
    state = [];
  }
}
