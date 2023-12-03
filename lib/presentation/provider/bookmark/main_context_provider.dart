import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_context_provider.g.dart';

/// bottom navi 가리는 bottom sheet 생성할 scaffod key provider
@Riverpod(keepAlive: true)
class MainContextNotifier extends _$MainContextNotifier {
  @override
  GlobalKey<ScaffoldState> build() {
    return GlobalKey<ScaffoldState>();
  }
}
