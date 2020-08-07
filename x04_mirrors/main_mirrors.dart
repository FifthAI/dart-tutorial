/// 知道dart给 flutter禁用反射，但是测试dart项目，我也引用不到，先不研究了
import "dart:mirrors";

void main() {
  var controller = GenericController<Foo>();
  controller.processRequest();
}

class GenericController<T extends RequestHandler> {
  void processRequest() {
    //T t = new T();
    T t = Activator.createInstance(T);
    t.tellAboutHimself();
  }
}

class Foo extends RequestHandler {
  void tellAboutHimself() {
    print("Hello, I am 'Foo'");
  }
}

abstract class RequestHandler {
  void tellAboutHimself();
}

class Activator {
  static createInstance(Type type, [Symbol constructor, List arguments, Map<Symbol, dynamic> namedArguments]) {
    if (type == null) {
      throw ArgumentError("type: $type");
    }

    if (constructor == null) {
      constructor = const Symbol("");
    }

    if (arguments == null) {
      arguments = const [];
    }

    var typeMirror = reflectType(type);
    if (typeMirror is ClassMirror) {
      return typeMirror.newInstance(constructor, arguments, namedArguments).reflectee;
    } else {
      throw ArgumentError("Cannot create the instance of the type '$type'.");
    }
  }
}
