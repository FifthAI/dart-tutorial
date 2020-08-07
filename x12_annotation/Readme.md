# 注解
本质上就是添加额外方法，属性。

因为是编译过程中添加属性，所以它是匿名的，代码开发中无法使用、提示等。

但是当运行时，它就是存在的，所以可以通过反射调用。dart这边需要mirrors这个库。

> 所以注解就可以为代码分析工具附加属性，例如 override required等。

> * 静态检查配置，查看x05
> * 静态检查插件，查看x13

有几个要点需要明确：
1. 注解都能用，只不过开发时代码中无法调用
2. 运行时调用注解内部方法，需要反射支持
    1. Flutter目前不支持mirror
    2. dart2native编译二进制，目前不能用mirrors库
3. @required、@override、等等注解支持，来自与dart：core，跟meta库，但是他们本身只是注解而已，跟代码高亮不是一个事儿
4. IDE的代码提示、高亮需要 dartfmt，dartanalyser支持
    1. analysis规则可以配置，针对analysis_options.yaml文件修改就可以
    2. 完全自定义代码提示等骚操作，需要实现analyser plugin。