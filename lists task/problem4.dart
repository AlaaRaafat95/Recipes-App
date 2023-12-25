void main() {
  var f = [7, 10, 15, 20, 25, 30];
  firstAndLast(f);
}

void firstAndLast(List<int> numbers) {
  List<int> c = [];
  c.add(numbers.first);
  c.add(numbers.last);
  print(c);
}
