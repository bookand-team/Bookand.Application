//북마크 버튼에 따라 토글되는 state
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_list_toggle.g.dart';

@Riverpod()
class MapListToggle extends _$MapListToggle {
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
