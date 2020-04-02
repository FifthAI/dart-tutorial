/// 测试删除list 回调类元素
typedef EngineMsgHandler = void Function(String data);
List<EngineMsgHandler> callbackList = List();

/// 全局的hashcode是一致的，
/// 作为callback函数传递，可以保证flutter在dispose时正确删除无效callback
void handler_g(str) {
  print("$str -> handler_g");
}

/// 动态创建的 handler 每次执行addTest生成的handler都是独立的，remove是有问题的。
void addTest(int t) {
  EngineMsgHandler handler_1 = (str) {
    print("$str -> handler_1");
  };
  EngineMsgHandler handler_2 = (str) {
    print("$str -> handler_2");
  };
  EngineMsgHandler handler_3 = (str) {
    print("$str -> handler_3");
  };

  callbackList.add(handler_g);
  callbackList.add(handler_1);
  callbackList.add(handler_1);
  callbackList.add(handler_2);
  callbackList.add(handler_2);
  callbackList.add(handler_3);
  callbackList.add(handler_3);
  callbackList.add(handler_g);

  callbackList.forEach((cb) {
    if (cb != null) cb("第$t次赋值 ${cb.hashCode}");
  });

  callbackList.remove(handler_g);

  callbackList.forEach((cb) {
    if (cb != null) cb("$t 删除一个全局g ${cb.hashCode}");
  });

  callbackList.remove(handler_2);

  callbackList.forEach((cb) {
    if (cb != null) cb("$t 删除一个h2 ${cb.hashCode}");
  });
}

main(List<String> args) {
  addTest(1);
  print("-----------");
  addTest(2);
}
