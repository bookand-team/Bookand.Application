import 'dart:async';

import 'package:bookand/page/article_detail_page.dart';
import 'package:bookand/page/login_page.dart';
import 'package:bookand/page/main_tab.dart';
import 'package:bookand/page/splash_page.dart';
import 'package:bookand/provider/user_me_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/model/user_model.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }

  List<GoRoute> get routes => [
        GoRoute(path: '/', name: MainTab.routeName, builder: (_, __) => const MainTab(), routes: [
          GoRoute(
              path: 'article/:name',
              builder: (_, state) => ArticleDetailPage(name: state.params['name']!))
        ]),
        GoRoute(
            path: '/splash', name: SplashPage.routeName, builder: (_, __) => const SplashPage()),
        GoRoute(path: '/login', name: LoginPage.routeName, builder: (_, __) => const LoginPage())
      ];

  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';

    if (user == null) {
      return logginIn ? null : '/login';
    }

    if (user is UserModel) {
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    return null;
  }
}
