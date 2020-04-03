/// dart里本来就是null，不要多余操作

int _nextId;

class LazyId {
  int _id;

  int get id {
    if (_nextId == null) _nextId = 0;
    if (_id == null) _id = _nextId++;

    return _id;
  }
}

int bad_nextId = null; // 不要赋空

class BadLazyId {
  int _id = null; // 不要赋空

  int get id {
    if (_nextId == null) _nextId = 0;
    if (_id == null) _id = _nextId++;

    return _id;
  }
}