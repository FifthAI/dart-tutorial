import 'dart:isolate';
// ignore: avoid_relative_lib_imports
import '../../../lib/analyzer_plugin_demo.dart' as plugin;

void main(List<String> args, SendPort sendPort) {
  plugin.start(args, sendPort);
  print('自定插件运行');
}
