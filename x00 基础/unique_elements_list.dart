import "dart:collection";

/// 有序，无序两种
void main() {
  // 有序输出
  List<String> arr = ["s","a", "a", "b", "c", "b", "d"];
  List<String> result = LinkedHashSet<String>.from(arr).toList();
  print(result); // => ["a", "b", "c", "d"]

  // 无序输出
  var ids = [6, 1, 4, 4, 4, 5, 6, 6];
  var distinctIds = ids.toSet().toList();
  print(distinctIds);
}