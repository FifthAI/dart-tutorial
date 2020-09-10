import 'dart:io';

main(List<String> args) {
  var self = Directory.current.uri.resolve('bin/').resolve('files/').resolve("demo.dart");
  var file = File.fromUri(self);
  String codes = file.readAsStringSync();
  print(codes);
}
