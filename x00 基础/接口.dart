/// dart的接口没有interface关键字定义接口，
/// 而是普通类或抽象类都可以作为接口被实现。
///
/// 使用implements关键字进行实现。
///
/// 如果实现的类是普通类，会将普通类和抽象中的属性的方法全部需要覆写一遍。
///
///
abstract class Db {
  //当做接口   接口：就是约定 、规范
  String uri; //数据库的链接地址
  add(String data);
  save();
  delete();
}

abstract class A {
  String name;
  printA();
}

abstract class B {
  printB();
}

/// 实现多个接口
class C implements A, B {
  @override
  String name;
  @override
  printA() {
    print('printA');
  }

  @override
  printB() {
    return null;
  }
}

void main() {
  C c = C();
  c.printA();
}
