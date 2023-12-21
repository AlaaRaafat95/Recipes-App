void main() {
  var b = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89];

  var c = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 21, 100, 55, 55, 55];
  var common = [];

  // first solution
  for (var element in b) {
    for (var element1 in c) {
      if (element == element1) {
        common.add(element);
      }
    }
  }
  print(common.toSet().toList());

  // second solution
  c.removeWhere((element) => !b.contains(element));
  print(c.toSet().toList());

  // third Solution
  var d = c.where((element) => b.contains(element));
  print(d.toSet().toList());
}
