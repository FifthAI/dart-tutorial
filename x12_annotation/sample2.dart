// /Users/fd/Downloads/dart-sdk/bin/dart2native ./x12_annotation/sample2.dart && ./x12_annotation/sample2.exe
// Dart支持元数据，该元数据用于将用户定义的注释附加到程序结构。
//--------------------------------
import 'package:meta/meta.dart';

class MyClass {
  final int value;
  final int value2;

  void printValue() {
    print('value: $value');
  }

  MyClass({
    @required this.value,
    @Required('测试注解，直接使用Required类型') this.value2,
  });
}

//------------------------------------------------
class Todo {
  final String reason;

  const Todo([this.reason = '没写，默认值']);
}

const Todo todo = Todo('继承');

class MyTodoClass {
  final int value;
  final int value2;

  void printValue() {
    print('value: $value');
  }

  MyTodoClass({
    @todo this.value,
    @Todo('测试注解，直接使用Required类型') this.value2,
  });
}

main() {
  // meta 自带required，dartfmt有代码检查与提示
  var m = MyClass(value: 1, value2: 2);
  m.printValue();

  var m1 = MyClass();
  m1.printValue();
}
