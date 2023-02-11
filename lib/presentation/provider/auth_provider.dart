import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/model/member_model.dart';
import '../screen/login_screen.dart';
import '../screen/main/article_screen.dart';
import '../screen/main/main_tab.dart';
import '../screen/splash_screen.dart';
import '../screen/terms/terms_agree_screen.dart';
import '../screen/terms/terms_detail_screen.dart';
import 'member_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    ref.listen<MemberModelBase?>(memberStateNotifierProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(path: '/', name: MainTab.routeName, builder: (_, __) => const MainTab(), routes: [
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
    final member = ref.read(memberStateNotifierProvider);

    if (member is MemberModelInit) {
      return '/login';
    }

    if (member is MemberModelSignUp) {
      if (state.location.startsWith('/login/termsAgree/termsAgreeDetail')) {
        return null;
      } else {
        return '/login/termsAgree';
      }
    }

    if (member is MemberModel) {
      return state.location.startsWith('/login') || state.location == '/splash' ? '/' : null;
    }

    return null;
  }
}
