# 几种暂停,时间机制.
1. sleep
2. Future.delay
3. Timer(const Duration(seconds: 10), () => print(DateTime.now()));
4. Stream.periodic

## sleep
不论在任何位置(同步、异步),sleep方式,直接暂停的是isolate. Flutter里表现为sleep后一次性刷新,暂停了所有刷新
## Future.delay
这是在异步中暂停的正确方式,并且以 `await Future.delay` 可以阻塞住异步方法. 模拟网络延迟,模拟等待处理,这是正确的选择
## Timer
这个并不能正常阻塞,但是是个定时任务
## Stream.periodic
这个对stream产生周期yield.抛出时间事件. 对stream进行listen,实现周期性任务.


# 摘录
If you're writing Dart code and you need to delay code execution for any reason, here are some ways to create delayed execution

All the methods below use Dart's Duration class to define the delay. It supports the following optional parameters:

days
hours
minutes
seconds
milliseconds
microseconds
Duration(seconds: 5) means 5 second delay. If you want to add a delaay of 1 minute and 10 seconds, use Duration(minutes: 1, seconds: 10).

Using sleep
The most basic way to sleep code execution is using sleep. However, be careful when using sleep as it blocks the main thread. At that time, it cannot process asynchronous operations in an isolate.

  print(DateTime.now());
  sleep(new Duration(seconds: 10));
  print(DateTime.now()); // This will be printed 10 seconds later.
Using Future.delayed
If you need to delay execution without blocking, you can use Future.delayed by passing a Duration object.

  print(DateTime.now());
  await Future.delayed(const Duration(seconds: 10));
  print(DateTime.now()); // This will be printed 10 seconds later.
Using Timer
With Timer, you can define a callback function that will be invoked after the duration.

  print(DateTime.now());
  new Timer(const Duration(seconds: 10), () => print(DateTime.now()));
Using Stream.periodic
Stream.periodic is used to create a stream that repeatedly emits events at periodic intervals. The code below create a Stream.periodic that will be executed for 100 times, with a delay of 10 seconds between two executions.

  var count = 0;
  final Stream myStream = new Stream.periodic(Duration(seconds: 10), (_)  => count++);
 
  myStream.map((val) {
    count = val;
    print('$count: ${DateTime.now()}');
 
    return val;
  }).take(100).forEach((e) {
    print(e);
  });