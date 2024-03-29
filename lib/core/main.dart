import 'dart:async';

import 'package:bookand/presentation/provider/router_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stack_trace/stack_trace.dart';

import 'app_strings.dart';
import 'config/app_init.dart';
import 'config/firebase/firebase_init.dart';
import 'theme/theme_data.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await initApplication();
    await initFirebase();
    FlutterError.demangleStackTrace = (StackTrace stack) {
      if (stack is Trace) return stack.vmTrace;
      if (stack is Chain) return stack.toTrace().vmTrace;
      return stack;
    };
    runApp(const ProviderScope(child: App()));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterStateNotifierProvider);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(360, 720),
        builder: (_, __) => MaterialApp.router(
              routeInformationProvider: router.routeInformationProvider,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              title: AppStrings.appName,
              theme: lightThemeData,
              darkTheme: darkThemeData,
              supportedLocales: const [Locale('ko', 'KR')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: child!),
            ));
  }
}
