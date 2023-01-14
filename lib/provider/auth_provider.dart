import 'package:bookand/screen/main/article_screen.dart';
import 'package:bookand/screen/login_screen.dart';
import 'package:bookand/screen/main/main_tab.dart';
import 'package:bookand/screen/splash_screen.dart';
import 'package:bookand/screen/terms/terms_detail_screen.dart';
import 'package:bookand/screen/terms/terms_agree_screen.dart';
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

  Future<void> refreshToken() async {
    await ref.read(userMeProvider.notifier).refreshToken();
  }

  List<GoRoute> get routes => [
        GoRoute(
            path: '/',
            name: MainTab.routeName,
            builder: (_, __) => const MainTab(),
            routes: [
              GoRoute(
                  path: 'article/:id',
                  name: ArticleScreen.routeName,
                  builder: (_, state) => ArticleScreen(name: state.params['id']!))
            ]),
        GoRoute(
            path: '/splash',
            name: SplashScreen.routeName,
            builder: (_, __) => const SplashScreen()),
        GoRoute(
            path: '/login',
            name: LoginScreen.routeName,
            builder: (_, __) => const LoginScreen(),
            routes: [
              GoRoute(
                  path: 'termsAgree',
                  name: TermsAgreeScreen.routeName,
                  builder: (_, __) => const TermsAgreeScreen(),
                  routes: [
                    GoRoute(
                        path: 'termsAgreeDetail/:id',
                        name: TermsAgreeDetailScreen.routeName,
                        builder: (_, state) => TermsAgreeDetailScreen(id: state.params['id']!))
                  ])
            ]),
      ];

  String? redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase user = ref.read(userMeProvider);

    if (user is UserModelInit) {
      return '/login';
    }

    if (user is UserModelSignUp) {
      if (state.location.startsWith('/login/termsAgree/termsAgreeDetail')) {
        return null;
      } else {
        return '/login/termsAgree';
      }
    }

    if (user is UserModel) {
      return state.location.startsWith('/login') ||
              state.location == '/splash'
          ? '/'
          : null;
    }

    return null;
  }
}
