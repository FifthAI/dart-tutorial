class Dog {
  @override
  String toString() {
    return '🐶';
  }
}

class Cat {
  @override
  String toString() {
    return '🐱';
  }
}

void myFunction(String s) {
  print("object $s");
}

void printAnimal(obj) {
  print('Animal {');
  print('  ${obj.toString()}');
  print('}');
}

main(List<String> args) {
  print("object");
  myFunction("123123123");
  myFunction("123123123");
  myFunction("123123123");
  myFunction("123123123");
  myFunction("123123123");
  myFunction("123123123");
  myFunction("123123123");
  myFunction("123123123");
  myFunction("123123123");

// Call printAnimal(...) a lot of times with an intance of Cat.
// As a result printAnimal(...) will be optimized under the
// assumption that obj is always a Cat.
  for (var i = 0; i < 50000; i++) {
    printAnimal(Cat());
  }

// Now call printAnimal(...) with a Dog - optimized version
// can not handle such an object, because it was
// compiled under assumption that obj is always a Cat.
// This leads to deoptimization.
  printAnimal(Dog());
}
