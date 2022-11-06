import 'package:bookand/provider/auth_provider.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/firebase/firebase_init.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider);

  return GoRouter(
      routes: provider.routes,
      initialLocation: '/splash',
      refreshListenable: provider,
      redirect: provider.redirectLogic,
      observers: [FirebaseAnalyticsObserver(analytics: analytics)]);
});
