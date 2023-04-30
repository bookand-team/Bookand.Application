import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_button_height_provider.g.dart';

@Riverpod()
class MapButtonHeightNotifier extends _$MapButtonHeightNotifier {
  @override
  double build() => bottom;
  //초기 높이
  static const double panelHeight = 200;
  static const double hideSheetHeight = 350;
  static const double bottom = 0;
  //패널 꺼졌을 때

  void updateHeight(double height) {
    if (height >= 0) {
      state = height;
    }
  }

  void toPanel() {
    updateHeight(panelHeight);
  }

  void toBottom() {
    updateHeight(0);
  }

  void updateHeightDelta(double delta) {
    if (state + delta >= 0) {
      state += delta;
    }
  }

  void toHideBottomSheet() {
    state = hideSheetHeight;
  }
}
