main(){
  // UI 过程，长时间异步运算应该用 delay 0，分割业务，不然会阻塞UI
  Future(() async {
    var result;
    for (var i = 0; i < 1000000; ++i) {
      result = 'result is $i';
      await Future.delayed(Duration.zero);
    }
    print(result);
  });
}