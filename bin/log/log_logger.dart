import 'dart:io' as io;
import 'package:logger/src/outputs/file_output.dart';
import 'package:logger/logger.dart';

String get _homePath {
  // String os = io.Platform.operatingSystem;
  String home = "";
  Map<String, String> envVars = io.Platform.environment;
  if (io.Platform.isMacOS) {
    home = envVars['HOME'];
  } else if (io.Platform.isLinux) {
    home = envVars['HOME'];
  } else if (io.Platform.isWindows) {
    home = envVars['UserProfile'];
  }
  return home;
}

Future<void> writeAFile() async {
  // print(strPath);
  var myFile = io.File(strPath);
  myFile.createSync(recursive: true);
  var sink = myFile.openWrite();
  sink.write('hello plugin!');
  await sink.flush();
  await sink.close();
}

var strPath = '$_homePath/lyProjects/samples/dart_demos/pluginDemoIsRunAndLog.txt';

var fileOutput = FileOutput(file: io.File(strPath), overrideExisting: true);

var logger = Logger();
// var logger = Logger(output: fileOutput);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

main(List<String> args) {
  // --enable-asserts 这个logger启动，dart 需要这个参数
  print('object');
  logger.v('message');
  loggerNoStack.v('message');
  print('object');
}
