main(List<String> args) {
  /// if else
  runIfElse();
  runWrongIfElse();

  runAssert(11, "df", "dfsdf");
}

runIfElse() {}

/// 执行执行时抛出了异常，异常的意思是int类型不能复制给bool类型。
runWrongIfElse() {
  try {
    var a = 1;
    assert(a.runtimeType == bool);
    // if (a) {
    //   // 与JavaScript不同的是，条件必须使用布尔值，不允许其他值。有关更多信息，请参见[布尔类型]。
    //   print('yes');
    // } else {
    //   print('error');
    // }
  } catch (e) {}
}

///
runFor() {
  var message = StringBuffer('Dart is fun');

  for (var i = 0; i < 5; i++) {
    message.write('!');
  }

  print(message);
}

///
runWrongFor() {}

runAssert(text, number, urlString) {
  // Make sure the variable has a non-null value.
  assert(text != null);

// Make sure the value is less than 100.
  assert(number.runtimeType == number);
  assert(number < 100);

// Make sure this is an https URL.
  assert(urlString.startsWith('https'));
}
