/// Good， 范型命名不要重合
class A<T> {
  void fn<U>() {}
}

/// Bad fn的T类型与AA的范型重合了
class AA<T> {
  void fn<T>() {}
}