import 'package:firebase_analytics/observer.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/firebase/firebase_init.dart';
import 'auth_provider.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final provider = ref.read(authProvider);

  return GoRouter(
      routes: provider.routes,
      initialLocation: '/splash',
      refreshListenable: provider,
      redirect: provider.redirectLogic,
      observers: [FirebaseAnalyticsObserver(analytics: analytics)]);
}
