/// typedef 用于定义特殊类型，可以断言特殊的类型，判断特殊的类型，是系统层面的
///
typedef Compare = int Function(Object a, Object b);

class SortedCollection {
  Compare compare;

  SortedCollection(this.compare);
}

// Initial, broken implementation.
int sort(Object a, Object b) => 0;

void main() {
  // 当给compare分配f时类型信息会丢失。f的类型是(Object, Object)->int(int表示返回值类型),当然compare的类型是Function。
  // 如果我们更改代码以使用显式名称和保留类型信息，开发人员和工具都可以使用这些信息。
  SortedCollection coll = SortedCollection(sort);
  assert(coll.compare is Function);
  assert(coll.compare is! Function);
  assert(coll.compare is Compare);
}
