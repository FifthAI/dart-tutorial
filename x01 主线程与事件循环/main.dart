import 'dart:async';
import 'dart:io';

void _doSomething() {
  // print(DateTime.now().millisecondsSinceEpoch);
  sleep(Duration(milliseconds: 500));
  print(DateTime.now().millisecondsSinceEpoch);
}

/// 同步循环，阻塞线程
void syncLoop() {
  for (int i = 0; i < 5; i++) {
    _doSomething();
  }
}

/// 测试 Micro & Event 顺序
void testEventLoopOrder() {
  Future(() => print('代码位置_1， Event事件队列'));
  scheduleMicrotask(() => print('代码位置_2， Micro小任务队列'));
  print('代码位置_3， 主isolate');
}

void main(List<String> args) {
  //               main Thread / isolate
  // start app ============================>
  //
  // dart 中 Thread 称之为 isolate
  syncLoop();
  // Flutter 或 Dart App启动以后，主isolate是唯一需要关心的
  // 主线程启动后，dart自动创建：
  // 1. 初始化2个队列，即“MicroTask”和“Event” FIFO队列;
  // 2. 执行main（）方法，并且一旦该代码执行完成;
  // 3. 启动 Event Loop 循环，（Micro 跟 Event两个都算）

  // Event Loop：事件循环
  // 线程执行期间，内部一个单一不可见的处理过程，可以称之为事件循环
  // 它可以驱动 MicroTask 和 Event 队列有序执行
  //
  // 伪代码，例如这样实现：
  // void eventLoop() {
  //   while (microTaskQueue.isNotEmpty) {
  //     fetchFirstMicroTaskFromQueue();
  //     executeThisMicroTask();
  //     return;
  //   }

  //   if (eventQueue.isNotEmpty) {
  //     fetchFirstEventFromQueue();
  //     executeThisEventRelatedCode();
  //   }
  // }
  //

  // MicroTask Queue：在Event队列之前，处理极短的内部操作；
  // 比如释放内部资源，先同步关闭程序，异步释放资源
  //
  // 伪代码，例如这样实现：
  // void closeAndRelease() {
  //   scheduleMicroTask(_dispose); // 释放
  //   _close(); // 关闭
  // }

  // void _close() {
  //   // 但是关闭是同步的，先执行
  // }

  // void _dispose() {
  //   // 执行在关闭之后，异步慢慢释放，
  // }

  // Event Queue ：处理 外部事件 与 Futrue

  //测试
  testEventLoopOrder();
  // 运行结果：
  // 代码位置_3， 主isolate
  // 代码位置_2， Micro小任务队列
  // 代码位置_1， Event事件队列

  // 事件循环是一个单线程循环，而不是基于时钟调度
  // （即它的执行只是按照Event处理完，就开始循环下一个Event，而与Java中的Thread调度不一样，没有时间调度的概念）

  // Futrue
  print("-" * 20);
  print("Futrue 链式调用");
  Future(() => print('拆分任务_1')) // 1. 这里被优先插入了Event Queue
      .then((i) => print('拆分任务_2'))
      .then((i) => print('拆分任务_3'))
      .whenComplete(() => print('任务完成'));
  // 执行后注意打印结果， （1.）先执行了，所以上一个的测试方法的打印顺序乱了

  // Microtask Queue存在的意义是：
  // 希望通过这个Queue来处理稍晚一些的事情，但是在下一个消息到来之前需要处理完的事情。
  // 当Event Looper正在处理Microtask Queue中的Event时候，Event Queue中的Event就停止了处理了，
  // 如果是Flutter，此时App不能绘制任何图形，不能处理任何鼠标点击，不能处理文件IO等等

  // 使用Future类，可以将任务加入到Event Queue的队尾
  // 使用scheduleMicrotask函数，将任务加入到Microtask Queue队尾

  // 细化讨论Future
  // 1. Future中的then并没有创建新的Event丢到Event Queue中，而只是一个普通的Function Call，在FutureTask执行完后，立即开始执行
  // 2. 当Future在then函数先已经执行完成了，则会创建一个task，将该task的添加到microtask queue中，并且该任务将会执行通过then传入的函数
  // 3. Future只是创建了一个Event，将Event插入到了Event Queue的队尾
  // 4. 使用Future.value构造函数的时候，就会和第二条一样，创建Task丢到microtask Queue中执行then传入的函数
  Future.value(() => print(
      "value print at microtask")); // 本条程序不会执行，EventQ发送到MicroQ，但是EQ为空，程序结束了。
  // 5. Future.sync构造函数执行了它传入的函数之后，也会立即创建Task丢到microtask Queue中执行
  Future.sync(() => print("sync print at microtask"));
  // Flutter中，当需要做动画的时候，不要使用Future，而需要使用animateFrame
  // Future.delay来将任务延迟执行，而如上所述，只有当Main isolate的Event Queue处于Idle的状态时，才会延迟1s执行，否则等待的时间会比1s长很多
  //
  void microtask() {
    print("object");
  }

  scheduleMicrotask(() => microtask());
}
