/// 利用接口的方式，
///
/// 把需要反射的类型，写成回调函数，传递给父类调用，
///
/// 从而实现在父类实现子类实例的操作
///
/// Flutter 用于widget，super.build()分层很有用
typedef S ItemCreator<S>();

class PagedListData<T> {
  // ...
  ItemCreator<T> creator;
  PagedListData(ItemCreator<T> this.creator) {}

  void performMagic() {
    T item = creator();
    // ...
  }
}

class AAA {

}


PagedListData<AAA> users =
    PagedListData<AAA>(() => AAA());
