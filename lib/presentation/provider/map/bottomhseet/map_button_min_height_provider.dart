//북마크 버튼에 따라 토글되는 state
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapButtonMinHeightProvider extends StateNotifier<double> {
  MapButtonMinHeightProvider() : super(0);
//초기 높이
  static const double storeSheetHeight = 300;
  static const double hideSheetHeight = 335;
  static const double bottom = 0;

  void setMinHeight(double height) {
    state = height;
  }

  double getHeight() {
    return state;
  }

  void toSheet() {
    setMinHeight(storeSheetHeight);
  }

  void toTwoSheet() {
    setMinHeight(2 * storeSheetHeight);
  }

  void toHideBottomSheet() {
    state = hideSheetHeight;
  }

  void toBottom() {
    setMinHeight(0);
  }
}

final mapButtonMinHeightNotifier =
    StateNotifierProvider<MapButtonMinHeightProvider, double>(
        (ref) => MapButtonMinHeightProvider());
