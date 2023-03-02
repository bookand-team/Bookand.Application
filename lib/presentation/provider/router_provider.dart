import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/firebase/firebase_init.dart';
import '../../core/const/auth_state.dart';
import '../../core/const/policy.dart';
import '../screen/login_screen.dart';
import '../screen/main/article_screen.dart';
import '../screen/main/main_tab.dart';
import '../screen/main/my/account_management_screen.dart';
import '../screen/main/my/notice_screen.dart';
import '../screen/main/my/notification_setting_screen.dart';
import '../screen/main/my/terms_and_policy_screen.dart';
import '../screen/splash_screen.dart';
import '../screen/terms/terms_agree_screen.dart';
import '../screen/terms/terms_detail_screen.dart';
import 'auth_provider.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
class GoRouterStateNotifier extends _$GoRouterStateNotifier {
  List<GoRoute> routes = [
    GoRoute(path: '/', name: MainTab.routeName, builder: (_, __) => const MainTab(), routes: [
      GoRoute(
          path: 'article/:id',
          name: ArticleScreen.routeName,
          builder: (_, state) => ArticleScreen(name: state.params['id']!))
    ]),
    GoRoute(
        path: '/splash', name: SplashScreen.routeName, builder: (_, __) => const SplashScreen()),
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
                    path: 'termsAgreeDetail',
                    name: TermsAgreeDetailScreen.routeName,
                    builder: (_, state) => TermsAgreeDetailScreen(policy: state.extra as Policy))
              ])
        ]),
    GoRoute(
        path: '/notificationSetting',
        name: NotificationSettingScreen.routeName,
        builder: (_, __) => const NotificationSettingScreen()),
    GoRoute(
        path: '/notice', name: NoticeScreen.routeName, builder: (_, __) => const NoticeScreen()),
    GoRoute(
        path: '/termsAndPolicy',
        name: TermsAndPolicyScreen.routeName,
        builder: (_, __) => const TermsAndPolicyScreen()),
    GoRoute(
        path: '/accountManagement',
        name: AccountManagementScreen.routeName,
        builder: (_, __) => const AccountManagementScreen()),
  ];

  @override
  GoRouter build() {
    ref.read(memberStateNotifierProvider.notifier).fetchMemberInfo();

    return GoRouter(
        routes: routes,
        initialLocation: '/splash',
        redirect: redirectLogic,
        refreshListenable: ref.watch(authStateNotifierProvider.notifier),
        observers: [FirebaseAnalyticsObserver(analytics: analytics)]);
  }

  String? redirectLogic(BuildContext context, GoRouterState goRouterState) {
    final authState = ref.read(authStateNotifierProvider);

    if (authState == AuthState.init) {
      return '/login';
    }

    if (authState == AuthState.signUp) {
      if (goRouterState.location.startsWith('/login/termsAgree/termsAgreeDetail')) {
        return null;
      } else {
        return '/login/termsAgree';
      }
    }

    if (authState == AuthState.signIn) {
      return goRouterState.location.startsWith('/login') || goRouterState.location == '/splash'
          ? '/'
          : null;
    }

    return null;
  }
}
