// 引入BenchmarkBase类
import 'package:benchmark_harness/benchmark_harness.dart';

// 通过继承BenchmarkBase创建一个新的测试
class TemplateBenchmark extends BenchmarkBase {
  const TemplateBenchmark() : super("Template");

  static void main() {
    TemplateBenchmark().report();
  }

  // 测试的代码
  void run() {
    var sss;
    for (var i = 0; i < 50; i++) {
      sss = '$i';
    }
    print(sss);
  }

  // 不计时：在测试运行之前，执行设置代码
  void setup() {}

  // 不计时：在测试运行之后，执行卸载代码
  void teardown() {}
}

main() {
  TemplateBenchmark.main();
}
