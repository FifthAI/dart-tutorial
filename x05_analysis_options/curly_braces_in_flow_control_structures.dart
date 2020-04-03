/// if else 等分支代码块，包裹在代码块里
class Other{
  final overflowChars=1;
}

bool badWay(){
  var other = Other();
  var overflowChars = 1;

  if (other == null) return false;  // 写在一行上是可以的

  if (overflowChars != other.overflowChars)
    return overflowChars < other.overflowChars;  // 没被大括号包裹
  else
    return false; // 没被大括号包裹
}