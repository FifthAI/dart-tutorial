代码分析插件，这部分属于`用代码`去`检查代码`。而且项目组织有些乱。因为插件附加到server执行，tools下的子启动项目会被复制到analyzer-server的cache路径。所以pubspec.yaml的依赖需要能定位到。

这里有坑：
1. 相对路径获取不到，
2. 打包上传仓库费劲
3. 推荐，绝对路径，进行开发；

# 静态分析

代码提示，代码高亮是由多方面组成的，官方提供了静态分析工具analyzer，分析的结果交由IDE插件，就可以着色高亮；

dart-sdk中提供了一个分析server，随IDE啥的配置而启动，这里有个API文档。
[Analysis Server Plugin API Specification Version 1.0.0-alpha.0](https://htmlpreview.github.io/?https://github.com/dart-lang/sdk/blob/master/pkg/analyzer_plugin/doc/api.html)

我们自定义规则可以分成2个角度。一个是对配置文件增减规则，配置我们的代码风格，linter。

另一个中就是编写插件，分析插件。完全自定代码检查规则、代码提示，代码修复等等。

# 插件
[sdk中原版指导](https://github.com/dart-lang/sdk/blob/master/pkg/analyzer_plugin/doc/tutorial/tutorial.md)

angular dart的项目，是不错的学习demo。对我来说，远比文档来的迅速。[angular-analyzer_plugin](https://github.com/dart-lang/angular/blob/master/angular/tools/analyzer_plugin/bin/plugin.dart)

# 启用插件
首先，对项目添加插件，pubspec中增加依赖，
```
dependencies:
  angular: ^5.3.1
  angular_components: ^0.13.0+1
```
然后在`analysis_options.yaml`配置额外的分析插件。
```
analyzer:
  plugins:
    - angular
```

> 本项目，自定义了package - analyzer_plugin_demo，并分别配置了 pubspec.yaml，analysis_options.yaml

# 编写插件。
项目会根据analysis_options.yaml配置的库，去.packages文件找对应路径的库。（是pub get生成缓存），从而启动插件。

所以，我们的analyzer_plugin_demo库，应当提供一个analyzer server需要的入口方法。

analyzer_plugin_demo库项目下，`新建tools/analyzer_plugin/bin`路径。`新建plugin.dart`文件
```dart
import 'dart:isolate';

void main(List<String> args, SendPort sendPort) {
  // Invoke the real main method in the plugin package.
  print('这里是插件的启动函数');
}
```



# 关于版本号，依赖规范 - 语义化版本 2.0.0
[语义化版本 2.0.0](https://semver.org/lang/zh-CN/)





# to be continue
dart collection : https://en.wikipedia.org/wiki/Cheney's_algorithm

https://github.com/dart-lang/sdk/blob/master/pkg/analyzer_plugin/doc/tutorial/tutorial.md
https://github.com/dart-lang/angular/blob/master/angular_analyzer_plugin/lib/plugin.dart
https://github.com/dart-lang/sdk/blob/master/pkg/analyzer_plugin/test/test_all.dart