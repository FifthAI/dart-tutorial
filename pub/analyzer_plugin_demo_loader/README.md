dart analyzer plugin demo

坑：

插件启动入口是tools下的路径，其实他是一个单独的项目，根据pubspec配置，analyzer会进行拉取项目，

但是，如果使用外部库，尤其是路径引用，就不会copy到执行路径。所以程序就会有问题。

本例最后直接在入口函数（plugin.dart）项目里写代码，

### 使用方式：
analysis_options.yaml文件中
```
analyzer:
  plugins:
    - host_package_1
    - host_package_2
```
1. 添加依赖，根据包名引用
2. 写路径引用

### 规定：
入口点文件与函数bin路径下的plugin.dart


