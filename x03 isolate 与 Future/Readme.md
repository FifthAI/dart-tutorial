# 基本概念
1. Isolate是Dart里的线程，每个Isolate之间不共享内存，通过消息通信；
2. Dart的代码运行在Isolate中，处于同一个Isolate的代码才能相互访问；
##  重要！原生平台通讯
原生平台通讯只支持 `main isolate`，主isolate有启动应用程序时创建

也就是说，原生平台不能使用main后创建的isolate实例通讯
# Future 与 Isolate选择策略
* 几～几十毫秒级操作 => Future
* 过百，几百毫秒级 => Isolate

## 一些需要Isolate的场景
* Json解析 -> compute
* 加密： 加密可能会非常耗时 -> Isolate
* Images：处理的图像（裁剪，例如）确实需要一些时间来完成的 -> Isolate
* 加载网络图像：可以考虑Isolate，先下载到本地，然后从本地一次性完成显示

#Demos
