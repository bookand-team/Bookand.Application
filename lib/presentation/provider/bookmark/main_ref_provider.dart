import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_ref_provider.g.dart';

/// ref 유지용
@Riverpod(keepAlive: true)
class MainRefNotifier extends _$MainRefNotifier {
  bool inited = false;
  @override
  WidgetRef? build() {
    return null;
  }

  void init(WidgetRef ref) {
    if (!inited) {
      state = ref;
    }
  }
}
