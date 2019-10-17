import 'dart:isolate';

/// dart 中 Thread == isolate
///
/// 每个isolate 是独立内存，只有开启isolate才是并行处理
///
/// isolate 需要 “port” 端口来通讯；
///
/// 注意，这里port的意思是dart内部的通讯“端口”，其实并不是网路通讯上的端口

SendPort newIsolateSendPort; // ioslate库，声明端口
Isolate newIsolate;

void callerCreateIsolate() async {
  print("EQ 新建isolate");
  ReceivePort receivePort = ReceivePort(); // 接收端口
  newIsolate = await Isolate.spawn(
    callbackFunction,
    receivePort.sendPort,
  );
  newIsolateSendPort = await receivePort.first;
  print("EQ 完成isolate ");
}

/// 新isolate的入口点
///
/// 注意：
/// 需要`全局方法` 或 `static` 声明 （可以理解为，一定得让isolate找到执行点）
void callbackFunction(SendPort callerSendPort) {
  ReceivePort newIsolateReceivePort = ReceivePort();
  callerSendPort.send(newIsolateReceivePort.sendPort);
  print("isolate 入口点");
  Future.delayed(Duration(seconds: 3), () => print("子isolate wait 3s"));
}

void main(List<String> args) {
  print("同步main() 主isolate启动");
  Future(callerCreateIsolate);
  Future.delayed(Duration(seconds: 4), () => print("主isolate wait 4s"));
  print("进入EventQueue 事件循环");
}

/// 原文
///
/// https://www.didierboelens.com/2019/01/futures---isolates---event-loop/
