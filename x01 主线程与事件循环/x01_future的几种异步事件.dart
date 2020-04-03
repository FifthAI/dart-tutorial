void asyncPrintEndLine(){
  print("------------------------------------------------------");
}
void main() {
  print("------------------------------------------------------");
  print("------虽然调用delayed在前，但是微任务先执行---------------");
  Future.delayed(Duration(microseconds: 1), () => print("delayed"));
  Future.microtask(() => print("microtask"));
  // 打印分割线。。。这里就是个骚操作，要在事件队列打印，分割才能达到效果
  // 虽然都是1微妙，但是它的队列靠后，是第二次循环才处理
  Future.delayed(Duration(microseconds: 1),asyncPrintEndLine);
  // -----------------------------------------------------------------
}
