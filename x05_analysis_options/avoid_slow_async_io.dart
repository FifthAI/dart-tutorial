/// 避免使用以下异步文件I/O方法，因为它们比同步同行要慢得多。
///
/// Directory.exists
/// Directory.stat
/// File.lastModified
/// File.exists
/// File.stat
/// FileSystemEntity.isDirectory
/// FileSystemEntity.isFile
/// FileSystemEntity.isLink
/// FileSystemEntity.type
///
///
import 'dart:io';

Future<Null> someFunction() async {
  var file = File('/path/to/my/file');
  var now = DateTime.now();
  if (file.lastModifiedSync().isBefore(now)) print('before'); // OK
}

/// 应该使用同步查看文件修改方法，
Future<Null> someBadFunction() async {
  var file = File('/path/to/my/file');
  var now = DateTime.now();
  if ((await file.lastModified()).isBefore(now)) print('before'); // LINT
}