import 'dart:isolate';
import 'package:analyzer_plugin_demo/analyzer_plugin_demo.dart' as plugin;

void main(List<String> args, SendPort sendPort) {
  plugin.start(args, sendPort);
  print('自定插件运行');
}
