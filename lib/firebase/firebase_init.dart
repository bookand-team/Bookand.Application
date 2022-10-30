import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../app_config.dart';
import 'firebase_options_dev.dart';
import 'firebase_options_product.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

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
