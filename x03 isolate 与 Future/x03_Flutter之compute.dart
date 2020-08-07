import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Compute归属'package:flutter/foundation.dart'，是Flutter特有，Dart原生包我没有找到。
///
/// 使用isolates的方法种：
///
/// * 高级API：Compute函数 (用起来方便 Flutter特有)
/// * 低级API：ReceivePort
///
/// Compute函数对isolate的创建和底层的消息传递进行了封装，使得我们不必关系底层的实现，只需要关注功能实现。
/// * 产生一个 新Isolate,
/// * 新 isolate执行携带的callbak&数据
/// * 返回结果是一个callback
/// * 当执行完成callback 结束产生的isolate
///
///
///
/// 不可直接运行，需要flutter项目
///
/// 原文：
/// https://juejin.im/post/5c3a06f56fb9a049d37f54f4
void main() async {
  //调用compute函数，compute函数的参数就是想要在isolate里运行的函数，和这个函数需要的参数
  print(await compute(syncFibonacci, 20)); // 高级API

  //asyncFibonacci函数里会创建一个isolate，并返回运行结果
  print(await asyncFibonacci(20)); // 自己实现
  runApp(Container(child: Text("sd")));
}

int syncFibonacci(int n) {
  return n < 2 ? n : syncFibonacci(n - 2) + syncFibonacci(n - 1);
}

//这里以计算斐波那契数列为例，返回的值是Future，因为是异步的
Future<dynamic> asyncFibonacci(int n) async {
  //首先创建一个ReceivePort，为什么要创建这个？
  //因为创建isolate所需的参数，必须要有SendPort，SendPort需要ReceivePort来创建
  final response = ReceivePort();
  //开始创建isolate,Isolate.spawn函数是isolate.dart里的代码,_isolate是我们自己实现的函数
  //_isolate是创建isolate必须要的参数。
  await Isolate.spawn(_isolate, response.sendPort);
  //获取sendPort来发送数据
  final sendPort = await response.first as SendPort;
  //接收消息的ReceivePort
  final answer = ReceivePort();
  //发送数据
  sendPort.send([n, answer.sendPort]);
  //获得数据并返回
  return answer.first;
}

//创建isolate必须要的参数
void _isolate(SendPort initialReplyTo) {
  final port = ReceivePort();
  //绑定
  initialReplyTo.send(port.sendPort);
  //监听
  port.listen((message) {
    //获取数据并解析
    final data = message[0] as int;
    final send = message[1] as SendPort;
    //返回结果
    send.send(syncFibonacci(data));
  });
}
