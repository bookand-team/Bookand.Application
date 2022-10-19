import 'package:bookand/page/login_page.dart';
import 'package:bookand/theme/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_config.dart';
import 'firebase/firebase_options_dev.dart';
import 'firebase/firebase_options_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "bookand_app.env");

  String? flavor = await const MethodChannel('flavor').invokeMethod<String>('getFlavor');
  AppConfig(flavor);

  await initFirebase();

  runApp(const ProviderScope(child: App()));
}

Future<void> initFirebase() async {
  switch (AppConfig.mode) {
    case devMode:
      await Firebase.initializeApp(
        options: FirebaseOptionsDev.currentPlatform,
      );
      break;
    case productMode:
      await Firebase.initializeApp(
        options: FirebaseOptionsProduct.currentPlatform,
      );
      break;
  }

  if (kReleaseMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
}

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book&',
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics)
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      home: _getStartScreen(),
    );
  }

  Widget _getStartScreen() {
    return const LoginPage();
  }
}
