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

import '../common/const/route_path.dart';
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
            path: RoutePath.home.path,
            name: MainTab.routeName,
            builder: (_, __) => const MainTab(),
            routes: [
              GoRoute(
                  path: 'article/:id',
                  name: ArticleScreen.routeName,
                  builder: (_, state) => ArticleScreen(name: state.params['id']!))
            ]),
        GoRoute(
            path: RoutePath.splash.path,
            name: SplashScreen.routeName,
            builder: (_, __) => const SplashScreen()),
        GoRoute(
            path: RoutePath.login.path,
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
      return RoutePath.login.path;
    }

    if (user is UserModelSignUp) {
      if (state.location.startsWith(RoutePath.termsAgreeDetail.path)) {
        return null;
      } else {
        return RoutePath.termsAgree.path;
      }
    }

    if (user is UserModel) {
      return state.location.startsWith(RoutePath.login.path) ||
              state.location == RoutePath.splash.path
          ? RoutePath.home.path
          : null;
    }

    return null;
  }
}
