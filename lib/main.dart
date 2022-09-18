import 'package:bookand/themes/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app/test_page.dart';
import 'config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "bookand_app.env");

  String? flavor =
      await const MethodChannel('flavor').invokeMethod<String>('getFlavor');
  Config(flavor);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book&',
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
