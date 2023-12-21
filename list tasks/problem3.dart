void main() {
  var d = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100];
  //first solution
  var e = [];
  d.forEach((element) {
    if (element.isEven) {
      e.add(element);
    }
  });

  print(e);
  // second solution
  var c = d.where((element) => element.isEven).toList();
  print(c);
}
