import 'dart:io';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

final logger = Logger(
  filter: ProductionFilter(),
  printer: PrefixPrinter(PrettyPrinter(
    colors: false,
    printTime: true,
  )),
  output: MultiOutput([
    FileOutput(),
    ConsoleOutput(),
  ]),
);

class FileOutput extends LogOutput {
  File? file;

  @override
  void init() async {
    super.init();
    final path = await generateLogFilePath();
    file = File(path);
  }

  @override
  void output(OutputEvent event) {
    event.lines.forEach(logWriteFile);
  }

  Future<String> generateLogFilePath() async {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final fileName = '${formatter.format(now)}.log';
    final appDocDir = await getApplicationDocumentsDirectory();
    final logDir = await Directory('${appDocDir.path}/logs').create();
    return '${logDir.path}/$fileName';
  }

  void logWriteFile(String msg) {
    if (file != null) {
      file!.writeAsStringSync('$msg\n', mode: FileMode.writeOnlyAppend, flush: true);
    }
  }
}
