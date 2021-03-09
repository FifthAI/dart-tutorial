import 'dart:async';
import 'dart:cli';

import 'dart:io';

Future<String> selectFriend(String friendId) async {
  await sleep(Duration(seconds: 3));
  return 'sadfasdf';
}

String selectFriendSync(String friendId) {
  var a;
  var c = Completer();
  print(1);
  print(232);

  // waitFor(future) // cli的库,命令行,服务端程序,可以在同步方法里等待异步.



  do {
    print(44);
    selectFriend(friendId).then((value){
      a = value;
      c.complete();
    });
    sleep(Duration(seconds: 1));
    selectFriend(friendId).then((value){
      a = value;
      c.complete();
    });
  } while (!c.isCompleted);
  return a;
}

// main(List<String> args) async {
//   print(await selectFriend('sdfsd'));
// }

main(List<String> args) {
  print(selectFriendSync('fasdfs'));
}
