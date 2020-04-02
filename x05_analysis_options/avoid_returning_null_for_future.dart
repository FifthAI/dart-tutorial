/// 1.8里没有规定
/// 因为当出错时候才会返回null，多数时候是忘记写async造成的
/// AVOID returning null for Future.
///
/// It is almost always wrong to return null for a Future. Most of the time the developer simply forgot to put an async keyword on the function.