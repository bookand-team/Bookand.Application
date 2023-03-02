import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/screen_state.dart';

part 'screen_provider.g.dart';

@Riverpod(keepAlive: true)
class ScreenStateNotifier extends _$ScreenStateNotifier {
  @override
  ScreenState build() => ScreenState.loading;

  void changeState(ScreenState screenState) {
    state = screenState;
  }
}
