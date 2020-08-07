main(List<String> args) {
  var url = 'postgres://kevin:@39.100.81.37:5432/kevin_db';

  print(Uri.encodeComponent(url));
  print(Uri.encodeComponent('kevin!@#'));
}