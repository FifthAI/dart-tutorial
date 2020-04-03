/// 消息的收发方式
import 'dart:isolate';

import 'package:meta/meta.dart';

SendPort newIsolateSendPort; // ioslate库，声明端口
Isolate newIsolate;

/// 定义通道传递类型
class CrossIsolatesMessage<T> {
  final SendPort sender;
  final T message;

  CrossIsolatesMessage({
    @required this.sender,
    this.message,
  });
}

Future<void> callerCreateIsolate() async {
  print("EQ 新建isolate");
  ReceivePort receivePort = ReceivePort(); // 接收端口
  newIsolate = await Isolate.spawn(
    callbackFunction,
    receivePort.sendPort,
  );
  newIsolateSendPort = await receivePort.first;
  print("EQ 完成isolate ");
}

Future<String> sendReceive(String messageToBeSent) async {
  // 创建临时端口接收消息
  ReceivePort port = ReceivePort();

  // 新建并发送一条消息到新isolate
  // 附带上我们的端口号
  newIsolateSendPort.send(CrossIsolatesMessage<String>(
    sender: port.sendPort,
    message: messageToBeSent,
  ));
  // 等临时端口回信
  return port.first;
}

//
// Extension of the callback function to process incoming messages
//
void callbackFunction(SendPort callerSendPort) {
  //
  // Instantiate a SendPort to receive message
  // from the caller
  //
  ReceivePort newIsolateReceivePort = ReceivePort();

  //
  // Provide the caller with the reference of THIS isolate's SendPort
  //
  callerSendPort.send(newIsolateReceivePort.sendPort);

  //
  // Isolate main routine that listens to incoming messages,
  // processes it and provides an answer
  //
  newIsolateReceivePort.listen((dynamic message) {
    CrossIsolatesMessage incomingMessage = message as CrossIsolatesMessage;

    //
    // Process the message
    //
    String newMessage = "complemented string " + incomingMessage.message;

    //
    // Sends the outcome of the processing
    //
    incomingMessage.sender.send(newMessage);
  });
}

/// async标记，本身就是Future，插入了事件循环
main(List<String> args) async {
  print("进入EventQueue 事件循环");
  print("main Future 开始");
  await callerCreateIsolate();
  print("main Future 结束");
}
