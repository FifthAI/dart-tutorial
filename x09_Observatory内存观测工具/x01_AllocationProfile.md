## 新生代、老年代
动态分配的Dart对象位于堆内存。通常，第一次分配对象时，将在Dart堆的新生代部分创建对象。该区域非常适合较小且存在时间短的对象，例如局部变量。新生代的gc是很经常的

新生代存在时间比较久的对象，会被移动到老年代，老年代比新生代要大，用来存放较大，较久的对象

## 功能
查看isolate的内存分配情况，提供一个累加器研究内存分配率，

右上提供两个按钮，一个gc，手动触发新、老代内存gc，另一个累加器计数归零

## 内存分配统计
提供饼图，新老跟合计，下面是分项占用列表