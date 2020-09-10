import 'dart:convert';
import 'dart:io';

import 'package:quick_log/quick_log.dart';

class QLogger extends Logger {
  final String filePath;
  const QLogger(String name, [filePath])
      : filePath = filePath ?? './quick_log.log',
        super(name, 'ExampleLogger');

  factory QLogger.createOutputToFile(String name, {String filePath}) {
    var logger = QLogger(name ?? 'Log', filePath);
    var fOutput = FileOutput(file: File(logger.filePath));
    fOutput.init();
    var w = LogStreamWriter();
    Logger.writer = w;
    w.messages.listen((LogMessage message) {
      fOutput.output('${message.timestamp} | ${message.message}');
    });
    return logger;
  }
}

class FileOutput {
  final File file;
  final bool overrideExisting;
  final Encoding encoding;
  IOSink _sink;

  FileOutput({
    this.file,
    this.overrideExisting = false,
    this.encoding = utf8,
  });

  void init() {
    _sink = file.openWrite(
      mode: overrideExisting ? FileMode.writeOnly : FileMode.writeOnlyAppend,
      encoding: encoding,
    );
  }

  void output(msg) {
    if (msg is Iterable) {
      _sink.writeAll(msg, '\n');
    } else if (msg is String) {
      _sink.writeln(msg);
    }
  }

  void destroy() async {
    await _sink.flush();
    await _sink.close();
  }
}

String get homePath {
  // String os = Platform.operatingSystem;
  String home = "";
  Map<String, String> envVars = Platform.environment;
  if (Platform.isMacOS) {
    home = envVars['HOME'];
  } else if (Platform.isLinux) {
    home = envVars['HOME'];
  } else if (Platform.isWindows) {
    home = envVars['UserProfile'];
  }
  return home;
}

Future<void> writeAFile(String path) async {
  // print(strPath);
  var myFile = File(path);
  myFile.createSync(recursive: true);
  var sink = myFile.openWrite();
  sink.write('hello plugin!');
  await sink.flush();
  await sink.close();
}
