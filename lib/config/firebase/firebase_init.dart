import 'dart:isolate';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../common/const/app_mode.dart';
import '../app_config.dart';
import 'firebase_options_dev.dart';
import 'firebase_options_product.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

Future<void> initFirebase() async {
  if (AppConfig.appMode == AppMode.production) {
    await Firebase.initializeApp(
      options: FirebaseOptionsProduct.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptionsDev.currentPlatform,
    );
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
      fatal: true,
    );
  }).sendPort);
}
