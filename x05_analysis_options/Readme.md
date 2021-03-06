# 官方文档 [goto](https://dart-lang.github.io/linter/lints/)
# 翻译官方文档，自己够用即可。不保证完整正确
- [avoid_empty_else](./avoid_empty_else.dart) # 避免空else代码块
- [avoid_init_to_null](./avoid_init_to_null.dart) # 避免初始化为null
- [avoid_relative_lib_imports](./avoid_relative_lib_imports.dart) # 避免lib库的相对引用
- [avoid_return_types_on_setters](./avoid_return_types_on_setters.dart) # 避免在setter方法返回类型
- [avoid_shadowing_type_parameters](./avoid_shadowing_type_parameters.dart) # 范型临时类型命名不一致
- [avoid_types_as_parameter_names](./avoid_types_as_parameter_names.dart) # 避免类型名作为参数名, 这条有点经验的程序猿，基本不会犯错
- [curly_braces_in_flow_control_structures](./curly_braces_in_flow_control_structures.dart) # 确保所有代码快都在大括号里
- empty_catches # 避免空catch代码块
- empty_constructor_bodies # 避免空构造函数
- library_names # 库名称用小写加下划线命名
- library_prefixes # 指定库前缀时 小写下划线
- no_duplicate_case_values # switch case时，避免case重复值
- null_closures # 不要传递null参数 （翻译可能有问题：Do not pass null as an argument where a closure is expected.）
- prefer_contains # 对list，string，使用contains函数，不用indexof
- prefer_equal_for_default_values # 用=赋值初始值，避免使用:赋值初始值，
- prefer_is_empty # 用 isEmpty 与 isNotEmpty. 判断数组等可迭代对象为空
- prefer_is_not_empty # 用 isEmpty 与 isNotEmpty. 判断数组等可迭代对象为空
- prefer_iterable_whereType # 用whereType代替where，（where需要as强转）
- recursive_getters # 避免返回自己，应当内外分开`int get field => _field;`
- slash_for_doc_comments # 三斜杠文档注释
- type_init_formals # 参数使用 this.x / 不要带类型 int this.x
- unawaited_futures # future结果必须await
- unnecessary_const # 非必须的const
- unnecessary_new # 非必须的new
- unnecessary_null_in_if_null_operators # 避免参数赋值空，good：var x = a ?? 1;
- unrelated_type_equality_checks # 避免不相关类型 == 比较； 就是说 比较两边的类型要一致
- use_rethrow_when_possible # catch里不要使用throw；要使用rethrow关键字
- [valid_regexps](./valid_regexps.dart) # 静态检查正则是否合法 
# 1.8里没有使用
- [avoid_print](./avoid_print.dart) # 生产环境代码不要使用print, （个人建议打开，想查看数据结构的话，使用打印后，可以吧结果作为注释）
- [avoid_returning_null_for_future](./avoid_returning_null_for_future.dart) # 避免让Future返回null, 
- [avoid_slow_async_io](./avoid_slow_async_io.dart) # 避免慢io异步,基本都是文件操作，需要使用同步方法更快
## 代码风格规则
## 包规则
- [package_names](./package_names.dart) # 包名用小写下划线，lowercase_with_underscores
- sort_pub_dependencies # yaml中的对pub包排序，便于维护