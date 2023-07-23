import 'package:bookand/presentation/provider/deeplink_provider.dart';
import 'package:bookand/presentation/screen/main/main_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'main/home/article_screen.dart';
import 'main/home/bookstore_screen.dart';

class DeeplinkScreen extends ConsumerStatefulWidget {
  static String get routeName => 'deeplink';

  final Map<String, String> queryParameters;

  const DeeplinkScreen({super.key, required this.queryParameters});

  @override
  ConsumerState<DeeplinkScreen> createState() => _DeeplinkScreenState();
}

class _DeeplinkScreenState extends ConsumerState<DeeplinkScreen> {
  @override
  void initState() {
    ref.read(deeplinkProviderProvider.notifier).fetchMemberInfo().then((_) {
      navigate();
      FlutterNativeSplash.remove();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(color: Colors.black);

  void navigate() {
    final String? route = widget.queryParameters['route'];
    final String? id = widget.queryParameters['id'];

    if (route == ArticleScreen.routeName && id != null) {
      context.goNamed(ArticleScreen.routeName, pathParameters: {'id': id});
      return;
    }

    if (route == BookstoreScreen.routeName && id != null) {
      context.goNamed(BookstoreScreen.routeName, pathParameters: {'id': id});
      return;
    }

    context.goNamed(MainTab.routeName);
  }
}
