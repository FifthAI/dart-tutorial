/// #  Description of the AST
///
/// [parser](http://lisperator.net/pltut/parser/)

/// input stream -> token(lexer) -> parser
/// 输入流 - 词法分析 - 语法解析器
///
/// * 输入流 实现的几个基本部分，用于辅助词法分析，生产tokenizer | The tokenizer (also called “lexer”)
///   * peek 读取，不删除
///   * next 读取后删除
///   * eof  是否末尾结束
///   * croak 异常结束、throw error
///
class InputCodeStream {
  final String code;
  var pos = 0, line = 1, col = 0;

  InputCodeStream(this.code);

  String next() {
    var ch;
    try {
      ch = code[pos++];
    } catch (e) {
      return '';
    }
    if (ch == "\n") {
      line++;
      col = 0;
    } else {
      col++;
    }
    return ch;
  }

  String peek() {
    var ch;
    try {
      ch = code[pos];
    } catch (e) {
      return '';
    }
    return ch;
  }

  bool eof() {
    return peek() == "";
  }

  String croak(msg) {
    throw Error.safeToString("$msg ($line:$col)");
  }
}

enum TokenType { punc, number, string, kw, variety, op }

/// * token 需要包含两部分： 类型、值
///
/// 例如：
/// ``` text
/// { type: "punc", value: "(" }           // punctuation: parens, comma, semicolon etc.
/// { type: "num", value: 5 }              // numbers
/// { type: "str", value: "Hello World!" } // strings
/// { type: "kw", value: "lambda" }        // keywords
/// { type: "var", value: "a" }            // identifiers
/// { type: "op", value: "!=" }            // operators
/// ```
class Tokenizer {
  final TokenType type;
  final String value;

  Tokenizer(this.type, this.value);
}

class Lexer {
  // static final RegExp numberRegExp = RegExp(r"^-?[0-9\.]+$"); // 字符串判断是数字
  // static final RegExp identityRegExp = RegExp(r'^-?[a-zA-Z_]\w+'); // 字符串判断是 keyword，或者id

  /// 本lexer是逐个读取字符的，所以只需要判断一个字符是什么类型就可以了
  // static final RegExp identityFirstCharRegExp = RegExp(r'[a-zA-Z_]');
  static final RegExp identityFirstCharRegExp = RegExp(r'[a-zλ_]');

  static final RegExp digitCharRegExp = RegExp(r'[0-9]');

  static const _keywords = " if then else lambda λ true false ";

  static bool isKeyword(String char) => _keywords.contains(' $char ');

  static bool isDigit(String char) => digitCharRegExp.hasMatch(char);

  static bool isPunctuation(String char) => ",;(){}[]".contains(char);

  static bool isOperator(String char) => "+-*/%=&|<>!".contains(char);

  static bool isIdentityFirstChar(String char) => identityFirstCharRegExp.hasMatch(char);
  static bool isIdentity(String ch) => isIdentityFirstChar(ch) || "?!-<>=0123456789".contains(ch);

  final InputCodeStream codeStream;
  Lexer(this.codeStream);

  Tokenizer stringTokenizer() {
    return Tokenizer(TokenType.string, takeStringBefore('"'));
  }

  String takeStringBefore(String stopAtChar) {
    var escaped = false, str = '';
    codeStream.next(); // 跳过前引号
    while (!codeStream.eof()) {
      var c = codeStream.next();
      if (escaped) {
        // 处理转译字符串
        str += c;
        escaped = false;
      } else if (c == '\\') {
        // 发现转译字符串 \
        escaped = true;
      } else if (c == stopAtChar) {
        // 结束字符串，返回
        break;
      } else {
        str += c; // 其他情况堆积数据
      }
    }

    return str;
  }

  Tokenizer numberTokenizer() {
    var hasDot = false;
    var number = loopCodeWhen((c) {
      if (c == '.') {
        if (hasDot) return false;
        hasDot = true;
        return true;
      }
      return isDigit(c); // 这里用的正则太复杂了，其实只检测[0-9]就行了，因为是单个字符
    });
    return Tokenizer(TokenType.number, number);
  }

  Tokenizer identTokenizer() {
    var id = loopCodeWhen(isIdentity);
    if (isKeyword(id)) {
      return Tokenizer(TokenType.kw, id);
    } else {
      return Tokenizer(TokenType.variety, id);
    }
  }

  Tokenizer puncTokenizer() {
    return Tokenizer(TokenType.punc, codeStream.next());
  }

  Tokenizer operatorTokenizer() {
    var op = loopCodeWhen(isOperator);
    return Tokenizer(TokenType.op, op);
  }

  /// 步骤：
  ///  * 空白需要跳过
  ///  * 读取到结束符 eof，返回null
  ///  * 首字符注释，跳过
  ///  * 如果是有效标记，开始读入字符串 （string）
  ///  * 如果它是一个数字，然后我们进行读数。（number）
  ///  * 如果这是一个“字符”，然后读标识符token或关键字token。 （identifier token 、 keyword token.）
  ///  * 如果是标点，返回一个标点token （punctuation token）
  ///  * 如果是计算符号，运算符号，标记一个运算token （operator token）
  ///
  /// 要点：检测用peek，真正提取字符串的位置用next处理字符串，跳过如引号等首字符
  Stream<Tokenizer> readNext() async* {
    loopCodeWhen(isWhiteSpace); // 跳过空白
    if (codeStream.eof()) {
      // 代码读取到头
      // yield null;
      return;
    }
    var char = codeStream.peek(); // 字符检测，语句判断
    if (char == "#") {
      skipComment();
      yield* readNext(); // 进入下次递归
    } else if (char == '"') {
      // 检测开头字符串，提取对应tokenizer
      yield stringTokenizer();
    } else if (isDigit(char)) {
      yield numberTokenizer();
    } else if (isIdentityFirstChar(char)) {
      yield identTokenizer();
    } else if (isPunctuation(char)) {
      yield puncTokenizer();
    } else if (isOperator(char)) {
      yield operatorTokenizer();
    } else {
      codeStream.croak('不能处理的字符 $char');
    }
    yield* readNext();
  }

  /// 根据条件连续读取
  /// predicate: 断言
  String loopCodeWhen(Function predicate) {
    var str = "";
    while (!codeStream.eof() && predicate(codeStream.peek())) {
      str += codeStream.next();
    }
    return str;
  }

  /// 空格，制表符，换行，都是 空白位
  static bool isWhiteSpace(char) => ' \n\t'.contains(char);

  /// 不换行，属于同一行
  static bool isInSameLine(char) => char != '\n';

  void skipComment() {
    loopCodeWhen(isInSameLine);
    codeStream.next(); // 吃掉换行 \n
  }
}

var sampleCode = '''
# this is a comment

println("Hello World!");

println(2 + 3 * 4);

# functions are introduced with `lambda` or `λ`
fib = lambda (n) if n < 2 then n else fib(n - 1) + fib(n - 2);

println(fib(15));

print-range = λ(a, b)             # `λ` is synonym to `lambda`
                if a <= b then {  # `then` here is optional as you can see below
                  print(a);
                  if a + 1 <= b {
                    print(", ");
                    print-range(a + 1, b);
                  } else println("");        # newline
                };
print-range(1, 5);
''';

main(List<String> args) async {
  var s = InputCodeStream(sampleCode);
  var lexer = Lexer(s);
  await for (var item in lexer.readNext()) {
    print('${item.type} -> ${item.value}');
  }
}

enum ParserToken {
  lambda,
}

class AstNode {
  final ParserToken type;

  AstNode(this.type);
}

class Parser {
  final Stream<Tokenizer> tokens;

  Parser(this.tokens);

  Stream<AstNode> next() async* {}

  List delimited(start, stop, separator, parser) {
    var a = [], first = true;
    skipPunc(start);
    while (!input.eof()) {
      if (is_punc(stop)) break;
      if (first)
        first = false;
      else
        skip_punc(separator);
      if (is_punc(stop)) break; // the last separator can be missing
      a.push(parser());
    }
    skip_punc(stop);
    return a;
  }

  static AstNode parseLambda() {
    return AstNode();
  }

  bool skipPunc(ch) {
    if (is_punc(ch))
      input.next();
    else
      input.croak("Expecting punctuation: \"" + ch + "\"");
  }
}
