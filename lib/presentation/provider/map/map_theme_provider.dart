import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_theme_provider.g.dart';

@Riverpod()
class MapThemeNotifier extends _$MapThemeNotifier {
  @override
  List<Themes> build() => [];

  toggleTheme(Themes theme) {
    if (state.contains(theme)) {
      state.remove(theme);
    } else {
      state.add(theme);
    }
  }

  setFromList(List<Themes> selectedThemes) {
    state = List.from(selectedThemes);
  }

  init() {
    state = [];
  }
}
