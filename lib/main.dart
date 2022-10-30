import 'package:bookand/page/login_page.dart';
import 'package:bookand/theme/theme_data.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_init.dart';
import 'firebase/firebase_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initFlavor();
  await Hive.initFlutter();
  await initEncryptionKey();
  await initFirebase();

  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
