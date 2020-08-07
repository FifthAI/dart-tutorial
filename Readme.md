# Dart & Flutter 相关基础知识练习
本项目基本不涉及运行Flutter App，但有Flutter相关知识点与代码

# 工具
* 安装dart环境，配置到环境变量/Flutter中的cache DartVM也可
* vscode
* vscode `Dart`插件 (`Flutter`插件也可)
* vscode `Code Runner`插件

> 每个*.dart脚本都携带main方法  
> 使用`Code Runner`插件可方便执行脚本程序 `Ctrl+Alt+N`

# 模块介绍
* aqueduct 3.3.0
    * web server
* dartfix 0.1.7
    * 代码工具，按规范替换代码
* dcdg 2.0.1
    * uml生成器，配合其他工具使用，生成uml图
* webdev 2.5.7
    * dart-web开发使用的server，（dart-web跟flutter不一样。。）
* stagehand 3.3.8
    * dart 项目生成器

# 脚手架工具
```shell script
# https://pub.dev/packages/stagehand
pub global activate stagehand
```
* console-simple - A simple command-line application.
* console-full - A command-line application sample.
* package-simple - A starting point for Dart libraries or applications.
* server-shelf - A web server built using the shelf package.
* web-angular - A web app with material design components.
* web-simple - A web app that uses only core Dart libraries.
* web-stagexl - A starting point for 2D animation and games.
```shell script
stagehand package-simple
```

# server框架
## aqueduct
* pub global activate aqueduct
    * aqueduct create 你的项目名