import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_hidestore_toggle.g.dart';

///숨은 서점 버튼에 따라 토글되는 hide store visible state
@Riverpod()
class HideStoreToggleNotifier extends _$HideStoreToggleNotifier {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }

  //hidestore bottomsheet 출력
  void activate() {
    state = true;
  }

  void deactivate() {
    state = false;
    ref.read(widgetMarkerNotiferProvider.notifier).setAllNormal();
  }
}

// final hideStoreToggleProvider =
//     StateNotifierProvider<HideStoreToggleNotifier, bool>(
//         (ref) => HideStoreToggleNotifier());
