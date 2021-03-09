|类别|关键字|返回类型|搭档|
|:--|:--|:--|:--|
|多元素同步|sync*|Iterable<T>|yield、yield*|
|单元素异步|async|Future<T>|await|
|多元素异步|async*|Stream<T>|yield、yield* 、await|

要点:

从dart的设计角度,同步方法内,无法阻塞异步.不要白费力气;
> 例外: 
> 命令行下 dart:cli库包含一个waitfor函数可以同步内阻塞等待异步

异步方式由两部分组成,
Future 与 Stream
* Future - 
    * async 定义方法体,返回Future
    * await 等待异步
* Stream - 
    * async* 定义方法体,返回Stream
    * yield  抛出一个Stream元素
    * yield* 抛出一串儿Stream元素
    * await  等待异步