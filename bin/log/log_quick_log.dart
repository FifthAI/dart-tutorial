import 'package:dart_tutorial/utils.dart';

var log = QLogger.createOutputToFile('aaa', filePath: './aaa.log');

void main() {
  // Logger.writer = ConsolePrinter(minLevel: LogLevel.debug, enableInReleaseMode: true);

  log.debug('this is a debug message');
  log.info('this is an info message');
}
