import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_button_height_provider.g.dart';

@Riverpod()
class MapButtonHeightNotifier extends _$MapButtonHeightNotifier {
  @override
  double build() => bottom;
  //초기 높이
  static const double bottom = 0;
  static const double storeSheetHeight = 300;
  static const double hideSheetHeight = 335;
  Timer? aniTimer;

  void updateHeight(double height) {
    if (height >= 0) {
      state = height;
    }
  }

  double getHeight() {
    return state;
  }

  void toSheet() {
    updateHeight(storeSheetHeight);
  }

  void toTwoSheet() {
    updateHeight(2 * storeSheetHeight);
  }

  void toHideBottomSheet() {
    state = hideSheetHeight;
  }

  void toBottom() {
    updateHeight(0);
  }

  void toBottomAnimation() {
    int count = 5;
    int i = 1;
    aniTimer = Timer.periodic(Duration(milliseconds: 150), (timer) {
      updateHeight(state - i * (state ~/ count));
      i += 1;
      if (state - i * (state ~/ count) <= 0) {
        state = 0;
        timer.cancel();
      }
    });
    updateHeight(0);
  }
}
