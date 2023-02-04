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
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final fileName = '${formatter.format(now)}.log';
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final logDir = await Directory('$appDocPath/logs').create();
    file = File('${logDir.path}/$fileName');
  }

  @override
  void output(OutputEvent event) {
    event.lines.forEach(logWriteFile);
  }

  void logWriteFile(String msg) {
    if (file != null) {
      file!.writeAsStringSync('$msg\n', mode: FileMode.writeOnlyAppend, flush: true);
    }
  }
}
