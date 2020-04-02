/// 静态检查正则是否合法
///
/// valid_regexps
void main(){
  // bad
  print(RegExp('(').hasMatch('foo()'));
  // good
  print(RegExp('[(]').hasMatch('foo()'));
}