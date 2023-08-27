import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/screen/deeplink_screen.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/folder_page/folder_page.dart';
import 'package:bookand/presentation/screen/main/home/bookstore_map_screen.dart';
import 'package:bookand/presentation/screen/main/map/map_searched_screen.dart';
import 'package:bookand/presentation/screen/main/map/map_searching_screen.dart';
import 'package:bookand/presentation/screen/main/my/error_report_screen.dart';
import 'package:bookand/presentation/screen/main/my/feedback_screen.dart';
import 'package:bookand/presentation/screen/main/my/newbookstorereport/new_bookstore_report_screen.dart';
import 'package:bookand/presentation/screen/main/my/thank_you_opinion_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/account_authentication_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/account_authentication_success_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/withdrawal_check_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/withdrawal_reason_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/withdrawal_success_screen.dart';
import 'package:bookand/presentation/screen/welcome_screen.dart';
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
        path: '/deeplink',
        name: DeeplinkScreen.routeName,
        builder: (_, state) =>
            DeeplinkScreen(queryParameters: state.queryParameters)),
    GoRoute(
        path: '/update',
        name: UpdateGuideScreen.routeName,
        builder: (_, __) => const UpdateGuideScreen()),
    GoRoute(
        path: '/',
        name: MainTab.routeName,
        builder: (_, __) => const MainTab(),
        routes: mainTabRoutes),
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
    GoRoute(
      path: '/welcome',
      name: WelcomeScreen.routeName,
      builder: (_, __) => const WelcomeScreen(),
    ),
  ];

  late List<RouteBase> mainTabRoutes = [
    GoRoute(
        path: 'article/:id',
        name: ArticleScreen.routeName,
        builder: (_, state) => ArticleScreen(
              id: state.pathParameters['id'],
              showCloseButton: state.queryParameters['showCloseButton'],
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
      path: 'mapSearch',
      name: MapSearchingScreen.routeName,
      builder: (_, __) => const MapSearchingScreen(),
    ),
    GoRoute(
      path: 'mapSearched',
      name: MapSearchedScreen.routeName,
      builder: (_, state) => MapSearchedScreen(
        query: state.queryParameters['query']!,
        searchedList: state.extra as List<BookStoreMapModel>,
      ),
    ),
    GoRoute(
        path: 'folder/:id/:name',
        name: FolderPage.routeName,
        builder: (_, state) => FolderPage(
              id: state.pathParameters['id']!,
              name: state.pathParameters['name']!,
            )),
    GoRoute(
        path: 'errorReport',
        name: ErrorReportScreen.routeName,
        builder: (_, __) => const ErrorReportScreen()),
    GoRoute(
        path: 'feedback',
        name: FeedbackScreen.routeName,
        builder: (_, __) => const FeedbackScreen()),
    GoRoute(
        path: 'thankYouOpinion',
        name: ThankYouOpinionScreen.routeName,
        builder: (_, __) => const ThankYouOpinionScreen()),
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

    if (authState == AuthState.welcome) {
      return '/welcome';
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
      final isLoginScreen = goRouterState.location.startsWith('/login');
      final isWelcomeScreen = goRouterState.location == '/welcome';

      if (isLoginScreen || isWelcomeScreen) {
        return '/';
      } else {
        return null;
      }
    }

    return null;
  }
}
