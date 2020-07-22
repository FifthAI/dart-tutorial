observatory是dart的内存观测工具，debug工具。

启动时增加参数 observe

`dart --observe <script>.dart`

然后得到输出，一个本地地址，就可以进入调试了

`Connect to Observatory at http://127.0.0.1:8181/v3rQnuLqwqk=/ to debug.`

此外，支持ssh跨机器登陆，不支持调试web应用，这些都不怎么重要。
# 功能介绍
* 内存分配
    * 显示隔离对象的已分配内存，概览老年代，新生代。
* 代码覆盖率 
* CPU配置文件 
    * https://dart-lang.github.io/observatory/cpu-profile.html
* 调试器 
* 计算表达式 
* 堆图 
* 隔离 
* 指标 
* 用户和虚拟机标签