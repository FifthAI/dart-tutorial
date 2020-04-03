import 'dart:convert';
import 'package:flutter/foundation.dart';

class Photo {
  String url;

  Photo(this.url);

  static fromJson(json) {}
}

//Future<List<Photo>> fetchPhotos(http.Client client) async {
//  final response =
//      await client.get('https://jsonplaceholder.typicode.com/photos');
//  return compute(parsePhotos, response.body);
//}

List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody);
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}


/// 不能快速运行，需要flutter
///
/// Flutter提供了支持并发计算的compute函数，它内部封装了Isolate的创建和双向通信；
///
/// 利用它我们可以充分利用多核心CPU，并且使用起来也非常简单；
main(List<String> args) async {
  int result = await compute(powerNum, 5); // 快速使用isolate函数
  print(result);
}

int powerNum(int num) {
  return num * num;
}
