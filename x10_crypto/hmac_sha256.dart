import 'dart:convert';

import 'package:crypto/crypto.dart';

String encodeMap(Map<String, String> data) {
  return data.keys.map((key) => "${Uri.encodeComponent(key)}=${Uri.encodeComponent(data[key])}").join("&");
}

var serverKey = '123123sdfsfsdfsadfs';
var clientKey = 'clientTest';
/// 对数据values url encode为表单格式字符串，使用hmac sha256生成数据签名
main(List<String> args) {
  var values = {'aaaa': 'abc', 'bbbb': 'abc'};
  final encode = encodeMap(values);
  final keyBytes = utf8.encode('${serverKey}${clientKey}'); // data being hashed
  final hmacSha256 = Hmac(sha256, keyBytes); // HMAC-SHA256
  final digest = hmacSha256.convert(utf8.encode(encode));
  values['sign'] = '$digest';

  print('------------------------------------------');
  print('被加密字符串 $encode');
  print('$values');
  print('------------------------------------------');
}
