// Dart支持元数据，该元数据用于将用户定义的注释附加到程序结构。
import 'dart:mirrors';

/// 创建注解
/// 只是一个构造方法需要修饰成 const 的普通 Class 。
class TestMetadata {
  const TestMetadata();
}

/// 使用，直接@
@TestMetadata()
class TestModel {}

/// 有参数的注解
class ParamMetadata {
  final String name;
  final int id;

  const ParamMetadata(this.name, this.id);
}

@ParamMetadata("test", 1)
class TestModel2 {}

//--------------------------------
class Todo {
  final String name;
  final String description;

  const Todo(this.name, this.description);
}

@Todo('Chibi', 'Rename class')
class MyClass {
  @Todo('Tuwaise', 'Change fielld type')
  int value;

  @Todo('Anyone', 'Change format')
  void printValue() {
    print('value: $value');
  }

  @Todo('Anyone', 'Remove this')
  MyClass();
}

main() {
  MyClass myClass = MyClass();
  InstanceMirror im = reflect(myClass);
  ClassMirror classMirror = im.type;

  classMirror.metadata.forEach((metadata) {
    if (metadata.reflectee is Todo) {
      print(metadata.reflectee.name);
      print(metadata.reflectee.description);
    }
  });
  print('--------');
  for (var v in classMirror.declarations.values) {
    if (v.metadata.isNotEmpty) {
      if (v.metadata.first.reflectee is Todo) {
        print(v.metadata.first.reflectee.name);
        print(v.metadata.first.reflectee.description);
      }
    }
  }
}
