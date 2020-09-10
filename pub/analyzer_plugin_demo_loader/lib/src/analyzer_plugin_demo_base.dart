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
import 'package:analyzer_plugin/utilities/fixes/fix_contributor_mixin.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'logger/log.dart';
//---------------------------------------------------------

var logPath = '$homePath/lyProjects/samples/dart_demos/pluginDemoIsRunAndLog.log';
var log = QLogger.createOutputToFile('plugin_demo', filePath: logPath);

class MyTodoPlugin extends ServerPlugin with AssistsMixin, DartAssistsMixin {
  MyTodoPlugin(ResourceProvider provider) : super(provider);

  @override
  List<String> get fileGlobsToAnalyze => <String>['**/*.dart', '**/*.log'];
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
    log.info('createAnalysisDriver');
    
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

//---------------------------------------------------------
void start(List<String> args, SendPort sendPort) {
  log.info('-----------restarted-------------');
  // 测试插件是否执行，执行后，demo路径下生成一个文件。
  //Future.delayed(Duration.zero, _writeAFile);
  ServerPluginStarter(MyTodoPlugin(PhysicalResourceProvider.INSTANCE)).start(sendPort);
}
