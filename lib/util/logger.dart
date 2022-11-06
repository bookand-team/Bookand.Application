import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  filter: LoggerFilter(),
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
  )
);

class LoggerFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (kReleaseMode) {
      switch (event.level) {
        case Level.verbose:
        case Level.debug:
        case Level.info:
        case Level.nothing:
          return false;
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