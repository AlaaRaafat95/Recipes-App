import 'car.dart';

class SportsCar extends Car {
  double? speed;

  SportsCar(
      {required super.brand,
      required super.model,
      required super.productionYear,
      required super.color,
      required super.price,
      super.maxNumberOfPassenger = 2,
      this.speed});
  @override
  void service() {
    super.service();
    print("$brand $model Use In Races Only");
  }

  void speedPerHour(double distane) {
    speed = double.parse(
      (distane / 60).toStringAsFixed(3),
    );
    print("The Speed of $brand $model Is $speed km/Min");
  }
}
