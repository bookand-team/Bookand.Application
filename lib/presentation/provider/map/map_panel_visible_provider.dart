import 'package:bookand/presentation/provider/map/map_button_height_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_panel_visible_provider.g.dart';

/// map panel visible 관리, map button height에 의존성 가짐
@Riverpod()
class MapPanelVisibleNotifier extends _$MapPanelVisibleNotifier {
  late MapButtonHeightNotifier buttonHeightCon;
  @override
  bool build() {
    buttonHeightCon = ref.read(mapButtonHeightNotifierProvider.notifier);
    return hide;
  }

  static bool show = true;
  static bool hide = false;

  ///panel을 끄고 킴, button height call상황에 따라 height 조정도 실행
  void toggle() {
    // 활성화 -> 비활성화
    if (state == show) {
      hidePanel();
    }
    // 비활성화 -> 활성화
    else {
      showPanel();
    }
  }

  void showPanel() {
    state = show;
    button2Panel();
  }

  void hidePanel() {
    state = hide;
    button2Bottom();
  }

  void button2Panel() {
    buttonHeightCon.toPanel();
  }

  void button2Bottom() {
    buttonHeightCon.toBottom();
  }
}
