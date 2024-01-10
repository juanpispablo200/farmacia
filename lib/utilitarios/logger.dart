import 'dart:io';

import 'package:logger/logger.dart';

var log = Logger(
  printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
      noBoxingByDefault: true),
  output: FileConsoleoutput(),
);

class FileConsoleoutput extends LogOutput {
  final file = File('logs.txt');
  final console = ConsoleOutput();

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      file.writeAsStringSync('$line\n', mode: FileMode.append);
      console.output(event);
    }
  }
}
