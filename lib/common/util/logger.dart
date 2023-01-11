import 'dart:io';

import 'package:bookand/config/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import '../const/app_mode.dart';

final logger = Logger(
  filter: _LoggerFilter(),
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
  ),
  output: _LoggerOutput(),
);

class _LoggerFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (AppConfig.appMode == AppMode.production) {
      switch (event.level) {
        case Level.verbose:
        case Level.debug:
        case Level.nothing:
          return false;
        case Level.info:
        case Level.warning:
        case Level.error:
        case Level.wtf:
          return true;
      }
    } else {
      return true;
    }
  }
}

class _LoggerOutput extends LogOutput {
  File? file;

  @override
  void init() async {
    super.init();
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    const fileName = 'bookand_logger.txt';
    file = File('$appDocPath/$fileName');
  }

  @override
  void output(OutputEvent event) async {
    for (var line in event.lines) {
      if (file != null) {
        await file!.writeAsString('${line.toString()}\n', mode: FileMode.writeOnlyAppend);
      }
      if (kDebugMode) {
        print(line);
      }
    }
  }
}
