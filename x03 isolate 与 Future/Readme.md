# Future 与 Isolate选择策略
* 几～几十毫秒级操作 => Future
* 过百，几百毫秒级 => Isolate

# compute

# 重要！原生平台通讯
原生平台通讯只支持 `main isolate`，主isolate有启动应用程序时创建

也就是说，原生平台不能使用预先创建的isolate实例通讯


# 一些需要Isolate的场景
* Json解析 -> compute
* 加密： 加密可能会非常耗时 -> Isolate
* Images：处理的图像（裁剪，例如）确实需要一些时间来完成的 -> Isolate
* 加载网络图像：可以考虑Isolate，先下载到本地，然后从本地一次性完成显示
