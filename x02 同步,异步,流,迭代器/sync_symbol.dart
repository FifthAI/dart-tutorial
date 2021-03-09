main() {
  print(getEmoji(10).length);
  
  getEmoji(10).forEach(print);
}
/// 迭代器.
/// 
/// sync* 返回的类型是迭代器. 内部配合 yield yield* 返回单个,或多个元素.
/// 
/// 迭代器可以返回长度.
Iterable<String> getEmoji(int count) sync* {
  Runes first = Runes('\u{1f47f}');
  for (int i = 0; i < count; i++) {
    yield String.fromCharCodes(first.map((e) => e + i));
  }
  yield '123';
}