import 'dart:isolate';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer_plugin/plugin/assist_mixin.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/starter.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/assist/assist_contributor_mixin.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';

class MyTodoPlugin extends ServerPlugin with AssistsMixin, DartAssistsMixin {
  MyTodoPlugin(ResourceProvider provider) : super(provider);

  @override
  List<String> get fileGlobsToAnalyze => <String>['**/*.dart'];
  // 可以选定多种文件范围
  // List<String> get fileGlobsToAnalyze => <String>['*.dart', '*.html'];

  @override
  String get name => '分析器插件demo，实现一个TODO提示';

  @override
  String get contactInfo => 'https://github.com/FifthAI/dart-tutorial';

  @override
  String get version => '1.0.0';

  /// 重要，分析器上下文
  @override
  AnalysisDriverGeneric createAnalysisDriver(ContextRoot contextRoot) {
    return null;
  }

  ///
  @override
  void sendNotificationsForSubscriptions(Map<String, List<AnalysisService>> subscriptions) {
    super.sendNotificationsForSubscriptions(subscriptions);
  }

  @override
  List<AssistContributor> getAssistContributors(String path) {
    return <AssistContributor>[MyAssistContributor()];
  }
}

class MyAssistContributor extends Object with AssistContributorMixin implements AssistContributor {
  static AssistKind wrapInIf = AssistKind('wrapInIf', 100, "Wrap in an 'if' statement");
  DartAssistRequest _request;
  AssistCollector _collector;

  @override
  AssistCollector get collector => _collector;

  AnalysisSession get session => _request.result.session;

  @override
  void computeAssists(AssistRequest request, AssistCollector collector) {
    _request = request;
    _collector = collector;
    _wrapInIf();
  }

  void _wrapInIf() {
    var builder = ChangeBuilder();
    addAssist(wrapInIf, builder);
  }
}

void start(List<String> args, SendPort sendPort) {
  Future.delayed(Duration.zero, _writeAFile);
  ServerPluginStarter(MyTodoPlugin(PhysicalResourceProvider.INSTANCE)).start(sendPort);
}

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

Future<void> _writeAFile() async {
  var strPath = '$_homePath/lyProjects/samples/dart_demos/pluginDemoIsRun.txt';
  print(strPath);
  var myFile = io.File(strPath);
  myFile.createSync(recursive: true);
  var sink = myFile.openWrite();
  sink.write('hello plugin!');
  await sink.flush();
  await sink.close();
}

// main(List<String> args) async {
//   await _writeAFile();
// }
