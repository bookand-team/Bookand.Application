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

  void addThemes(List<String> selectedThemes) {
    state = selectedThemes;
  }

  void initThemes() {
    state = [];
  }
}
