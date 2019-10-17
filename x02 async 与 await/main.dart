/// # async await
/// 当一个方法标记为async时意味着
///
/// 1. 输出其实就是一个`Future`，一个对EventQueue的插入操作
/// 2. 将会同步运行到第一个 `await` 关键字
/// 3. `await` 标记的这行代码将会被下次`Futrue`完成
///
void main() async {
  // 测试1. - await的阻塞效果
  // 运行程序，切换methodC的（1.）（2.），查看打印状态
  methodA();
  await methodB();
  await methodC('main');
  methodD();

  // 测试2.
  // method1();

  // 测试3.
  // method2();
}

methodA() {
  print('A');
}

methodB() async {
  print('B start');
  await methodC('B');
  print('B end');
}

/// 不稳定因素
///
/// 注意1. 代码段
///
/// 如果本方法运行在服务端，这里将会导致methodC的处理时长不可预测，很难说它什么时候完成
///
/// 切换代码到2. 重新执行程序查看结果
///
/// 一个`await`关键字改变了整个程序的逻辑；
methodC(String from) async {
  print('C start from $from');

  // 1.
  Future(() {
    print('C running Future from $from');
  }).then((_) {
    print('C end of Future from $from');
  });

  // 2.
  // await Future(() {
  //   print('C running Future from $from');
  // }).then((_) {
  //   print('C end of Future from $from');
  // });

  print('C end from $from');
}

methodD() {
  print('D');
}

/// 每次迭代，产生一次 async（其实就是Future插入了EventQueue队尾）
///
/// 可以这么看待async
/// ```text
/// A() async { await B() }
///   ==> [async] [A()] { [B()] [await] }
///     ==> [async] -> Future | [await] -> .then()
///       ==> Future(A(){B()}).then()
/// = Future((){B()}).then();
/// ```
/// 所以，迭代的位置同步产生了Future插入EventQueue操作3次
void method1() {
  List<String> myArray = <String>['a', 'b', 'c'];
  print('before loop');
  myArray.forEach((String value) async {
    await delayedPrint(value);
  });
  print('end of loop');
}

/// 本方法虽然是async标记，当执行时，直接排到了事件队尾
///
/// 执行到方法体时，同步方法出发 碰到await，进入了等待过程、
///
/// 之后每次同步for迭代，产生一次await效果
void method2() async {
  List<String> myArray = <String>['a', 'b', 'c'];
  print('before loop');
  for (int i = 0; i < myArray.length; i++) {
    await delayedPrint(myArray[i]);
  }
  print('end of loop');
}

Future<void> delayedPrint(String value) async {
  await Future.delayed(Duration(seconds: 1));
  print('delayedPrint: $value');
}

/// 原文
///
/// https://www.didierboelens.com/2019/01/futures---isolates---event-loop/
///
///
