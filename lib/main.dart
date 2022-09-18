import 'package:bookand/themes/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app/test_page.dart';
import 'app_config.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "bookand_app.env");

  String? flavor = await const MethodChannel('flavor').invokeMethod<String>('getFlavor');
  AppConfig(flavor);

  await initFirebase();

  runApp(const App());
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (AppConfig.mode == productMode) {
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
    return const TestPage();
  }
}
