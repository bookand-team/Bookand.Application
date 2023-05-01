import 'package:bookand/presentation/provider/map/map_button_height_provider.dart';
import 'package:bookand/presentation/screen_logic/map/toggle_logic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_panel_visible_provider.g.dart';

/// map panel visible 관리, map button height에 의존성 가짐, 의존성 있으므로 따로 분리
@Riverpod()
class MapPanelVisibleNotifier extends _$MapPanelVisibleNotifier
    implements ToggleLogic {
  late MapButtonHeightNotifier buttonHeightCon;
  @override
  bool build() {
    buttonHeightCon = ref.read(mapButtonHeightNotifierProvider.notifier);
    return false;
  }

  ///panel을 끄고 킴, button height call상황에 따라 height 조정도 실행
  @override
  void toggle() {
    // 활성화 -> 비활성화
    if (state == true) {
      deactivate();
    }
    // 비활성화 -> 활성화
    else {
      activate();
    }
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
