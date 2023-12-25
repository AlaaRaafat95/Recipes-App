void main() {
  var a = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89];

  //first Solution
  var b = a.where((element) => element < 5);
  print(b);

  //Second Solution
  for (var element in a) {
    if (element < 5) {
      print(element);
    }
  }
}
