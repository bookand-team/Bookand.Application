import 'package:bookand/presentation/screen/main/bookmark/components/folder_page/folder_page.dart';
import 'package:bookand/presentation/screen/main/home/bookstore_map_screen.dart';
import 'package:bookand/presentation/screen/main/map/component/search_screen/map_search_screen.dart';
import 'package:bookand/presentation/screen/main/my/feedback/feedback_screen.dart';
import 'package:bookand/presentation/screen/main/my/feedback/feedback_send_success_screen.dart';
import 'package:bookand/presentation/screen/main/my/newbookstorereport/new_bookstore_report_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/account_authentication_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/account_authentication_success_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/withdrawal_check_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/withdrawal_reason_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/withdrawal_success_screen.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tuple/tuple.dart';

import '../../core/config/firebase/firebase_init.dart';
import '../../core/const/auth_state.dart';
import '../../domain/model/policy_model.dart';
import '../screen/login_screen.dart';
import '../screen/main/home/article_screen.dart';
import '../screen/main/home/bookstore_screen.dart';
import '../screen/main/main_tab.dart';
import '../screen/main/my/account_management_screen.dart';
import '../screen/main/my/newbookstorereport/new_bookstore_report_success.dart';
import '../screen/main/my/notice_screen.dart';
import '../screen/main/my/notification_setting_screen.dart';
import '../screen/main/my/terms_and_policy_screen.dart';
import '../screen/terms/terms_agree_screen.dart';
import '../screen/terms/terms_detail_screen.dart';
import '../screen/update_guide_screen.dart';
import 'auth_provider.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
class GoRouterStateNotifier extends _$GoRouterStateNotifier {
  late List<GoRoute> routes = [
    GoRoute(
        path: '/update',
        name: UpdateGuideScreen.routeName,
        builder: (_, __) => const UpdateGuideScreen()),
    GoRoute(
        path: '/',
        name: MainTab.routeName,
        builder: (_, __) => const MainTab(),
        routes: mainTabRoutes),
    // GoRoute(
    //     path: '/splash', name: SplashScreen.routeName, builder: (_, __) => const SplashScreen()),
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
                    builder: (_, state) => TermsAgreeDetailScreen(
                        policy: state.extra as Tuple2<int, PolicyModel>))
              ]),
        ]),
  ];

  late List<RouteBase> mainTabRoutes = [
    GoRoute(
        path: 'article/:id/:isFirstScreen',
        name: ArticleScreen.routeName,
        builder: (_, state) => ArticleScreen(
              id: state.pathParameters['id']!,
              isFirstScreen: state.pathParameters['isFirstScreen']!,
            )),
    GoRoute(
        path: 'bookstore/:id',
        name: BookstoreScreen.routeName,
        builder: (_, state) =>
            BookstoreScreen(id: state.pathParameters['id']!)),
    GoRoute(
        path: 'bookstoreMap/:latitude/:longitude',
        name: BookstoreMapScreen.routeName,
        builder: (_, state) => BookstoreMapScreen(
              latitude: state.pathParameters['latitude']!,
              longitude: state.pathParameters['longitude']!,
            )),
    GoRoute(
        path: 'notificationSetting',
        name: NotificationSettingScreen.routeName,
        builder: (_, __) => const NotificationSettingScreen()),
    GoRoute(
        path: 'notice',
        name: NoticeScreen.routeName,
        builder: (_, __) => const NoticeScreen()),
    GoRoute(
        path: 'termsAndPolicy',
        name: TermsAndPolicyScreen.routeName,
        builder: (_, __) => const TermsAndPolicyScreen()),
    GoRoute(
        path: 'accountManagement',
        name: AccountManagementScreen.routeName,
        builder: (_, __) => const AccountManagementScreen(),
        routes: accountManagementRoutes),
    GoRoute(
        path: 'newBookstoreReport',
        name: NewBookstoreReportScreen.routeName,
        builder: (_, __) => const NewBookstoreReportScreen()),
    GoRoute(
        path: 'newBookstoreReportSuccess',
        name: NewBookstoreReportSuccessScreen.routeName,
        builder: (_, __) => const NewBookstoreReportSuccessScreen()),
    GoRoute(
        path: 'feedback',
        name: FeedbackScreen.routeName,
        builder: (_, __) => const FeedbackScreen()),
    GoRoute(
        path: 'feedbackSendSuccessScreen',
        name: FeedbackSendSuccessScreen.routeName,
        builder: (_, __) => const FeedbackSendSuccessScreen()),
    GoRoute(
      path: 'mapSearch',
      name: MapSearchScreen.routeName,
      builder: (_, __) => const MapSearchScreen(),
    ),
    GoRoute(
        path: 'folder/:id/:name',
        name: FolderPage.routeName,
        builder: (_, state) => FolderPage(
              id: state.pathParameters['id']!,
              name: state.pathParameters['name']!,
            )),
  ];

  List<RouteBase> accountManagementRoutes = [
    GoRoute(
        path: 'withdrawalCheck',
        name: WithdrawalCheckScreen.routeName,
        builder: (_, __) => const WithdrawalCheckScreen()),
    GoRoute(
        path: 'withdrawalReason',
        name: WithdrawalReasonScreen.routeName,
        builder: (_, __) => const WithdrawalReasonScreen()),
    GoRoute(
        path: 'accountAuthentication',
        name: AccountAuthenticationScreen.routeName,
        builder: (_, __) => const AccountAuthenticationScreen()),
    GoRoute(
        path: 'accountAuthenticationSuccess',
        name: AccountAuthenticationSuccessScreen.routeName,
        builder: (_, state) => AccountAuthenticationSuccessScreen(
              socialAccessToken: state.extra as String,
            )),
    GoRoute(
        path: 'withdrawalSuccessScreen',
        name: WithdrawalSuccessScreen.routeName,
        builder: (_, __) => const WithdrawalSuccessScreen())
  ];

  @override
  GoRouter build() => GoRouter(
      routes: routes,
      initialLocation: '/login',
      redirect: redirectLogic,
      refreshListenable: ref.watch(authStateNotifierProvider.notifier),
      observers: [FirebaseAnalyticsObserver(analytics: analytics)]);

  String? redirectLogic(BuildContext context, GoRouterState goRouterState) {
    final authState = ref.read(authStateNotifierProvider);

    if (authState == AuthState.update) {
      return '/update';
    }

    if (authState == AuthState.init) {
      return '/login';
    }

    if (authState == AuthState.signUp) {
      if (goRouterState.location
          .startsWith('/login/termsAgree/termsAgreeDetail')) {
        return null;
      } else {
        return '/login/termsAgree';
      }
    }

    if (authState == AuthState.signIn) {
      return goRouterState.location.startsWith('/login') ||
              goRouterState.location == '/splash'
          ? '/'
          : null;

      // return goRouterState.location.startsWith('/login') ? '/' : null;
    }

    return null;
  }
}
