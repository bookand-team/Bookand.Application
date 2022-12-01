import 'package:bookand/page/article_detail_page.dart';
import 'package:bookand/page/login_page.dart';
import 'package:bookand/page/main/main_tab.dart';
import 'package:bookand/page/splash_page.dart';
import 'package:bookand/page/terms/terms_detail_page.dart';
import 'package:bookand/page/terms/terms_agree_page.dart';
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
        GoRoute(path: '/', name: MainTab.routeName, builder: (_, __) => const MainTab(), routes: [
          GoRoute(
              path: 'article/:id',
              name: ArticleDetailPage.routeName,
              builder: (_, state) => ArticleDetailPage(name: state.params['id']!))
        ]),
        GoRoute(
            path: '/splash', name: SplashPage.routeName, builder: (_, __) => const SplashPage()),
        GoRoute(
            path: '/login',
            name: LoginPage.routeName,
            builder: (_, __) => const LoginPage(),
            routes: [
              GoRoute(
                  path: 'termsAgree',
                  name: TermsAgreePage.routeName,
                  builder: (_, __) => const TermsAgreePage(),
                  routes: [
                    GoRoute(
                        path: 'termsAgreeDetail/:id',
                        name: TermsAgreeDetailPage.routeName,
                        builder: (_, state) => TermsAgreeDetailPage(id: state.params['id']!))
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
      return state.location.startsWith('/login') || state.location == '/splash' ? '/' : null;
    }

    return null;
  }
}
