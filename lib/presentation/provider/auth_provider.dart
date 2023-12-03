import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/auth_state.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthStateNotifier extends _$AuthStateNotifier with ChangeNotifier {
  @override
  AuthState build() => AuthState.loading;

  void changeState(AuthState authState) {
    state = authState;
    notifyListeners();
  }
}
