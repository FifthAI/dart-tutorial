import 'dart:async';
import 'dart:isolate';

// 全局的isolate，函数方便获取
Isolate isolate;
// 接收器也得需要close，释放。
ReceivePort receivePort;
// 启动新的Isolate，并监听消息
start() async {
  receivePort = ReceivePort();
  // 孵化isolate
  isolate = await Isolate.spawn(entryPoint, receivePort.sendPort, debugName: 'newIsolate');

  receivePort.listen((message) {
    // isolate的回调，抵达主isolate
    print('${Isolate.current.debugName}: receive msg $message');
  });
  print('${Isolate.current.debugName}: spawn');
}

// 使用spawn孵化新Isolate / 入口函数
entryPoint(SendPort sendPort) {
  int counter = 0;
  Timer.periodic(Duration(seconds: 1), (Timer t) {
    print('${Isolate.current.debugName}: send msg ${counter++}');
    sendPort.send(DateTime.now());
  });
}

// 结束Isolate
void stop() {
  if (isolate != null) {
    isolate.kill(priority: Isolate.immediate);
    isolate = null;
    print('${Isolate.current.debugName}: killed isolate');
  }
}

/// 开启任务，10秒后关闭
void main() {
//  print(Isolate.current.debugName); // 可以获取当前isolate的名称
  Future.microtask(start); // 加入微任务队列，打开isolate
//  Future.delayed(Duration(microseconds: 1),start); // 事件队列，打开isolate
  //主任务delay10秒，然后结束isolate，最后自己事件循环结束，整体结束
  Future.delayed(Duration(seconds: 3), () => {stop()}).whenComplete(() {
    print("还要结束监听！！！！不然主Isolate ${Isolate.current.debugName} 不结束");
    receivePort.close();
//    exit(1);
  });
}
