main(List<String> args) {
    var count = 0;
  final Stream myStream = Stream.periodic(Duration(seconds: 10), (_)  => count++);
 
  myStream.map((val) {
    count = val;
    print('$count: ${DateTime.now()}');
 
    return val;
  }).take(100).forEach((e) {
    print(e);
  });
}